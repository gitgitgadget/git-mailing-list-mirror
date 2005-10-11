From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 09:11:11 -0700
Message-ID: <434BE41F.4060909@zytor.com>
References: <20051010105008.GB30202@gentoo.org> <81b0412b0510110802lbcdebe0m17bce7ca81ea76d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elfyn McBratney <beu@gentoo.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 18:14:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPMjA-0002ql-Hi
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 18:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJKQLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVJKQLi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 12:11:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20676 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932153AbVJKQLh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 12:11:37 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9BGBBj6009556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Oct 2005 09:11:12 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510110802lbcdebe0m17bce7ca81ea76d2@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9973>

Alex Riesen wrote:
> On 10/10/05, Elfyn McBratney <beu@gentoo.org> wrote:
> 
>>        int main (int argc, char **argv)
>>        {
>>                set_prog_name(argv[0]);
> 
> 
> I'd also use readlink on /proc/self/exe by default (if set_prog_name
> _not_ called).
> It simplifies the code at least on linux, and makes possible very slow
> transition for other platforms. So you don't have to update each and
> every .c file containing "main[[:space:]]*(" ;)

It's really better just to put the stuff at the beginning of each main. 
  If that's too annoying, librarize main and rename your mains "git_main".

	-hpa
