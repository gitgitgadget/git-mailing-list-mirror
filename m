From: Jehan Bing <jehan@orb.com>
Subject: Re: "Nested quantifiers" error in gitweb with "++" in the filename
Date: Fri, 23 Dec 2011 11:37:23 -0800
Message-ID: <4EF4D873.4090803@orb.com>
References: <jd04eq$9m0$1@dough.gmane.org> <CANgJU+VA9s9t0c8D0P_DesbSDQRBQ6v913KixKQAuiy8jZsdzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 20:37:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReAvv-0002hC-0v
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 20:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab1LWThb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 14:37:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:55872 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab1LWTh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 14:37:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ReAvo-0002eN-HX
	for git@vger.kernel.org; Fri, 23 Dec 2011 20:37:28 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 20:37:28 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 20:37:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CANgJU+VA9s9t0c8D0P_DesbSDQRBQ6v913KixKQAuiy8jZsdzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187638>

On 2011-12-23 08:02, demerphq wrote:
> On 22 December 2011 21:37, Jehan Bing<jehan@orb.com>  wrote:
>> Hi,
>>
>> I'm getting an error when trying to look at a blob when the filename has
>> "++" in it:
>>
>> http://.../blob/13ec1624fefc23d20d0407aac3337b35844a2ceb:/foo-++.txt
>
> This error comes because the filename is being used a pattern without
> being protected by a quotemeta.
>
> Interestingly, a later version of perl would not have this problem as
> ++ is a legal quantifier as of 5.10, nevertheless it probably wouldnt
> do what you expected.
>

Interestingly, a later version of perl would not have this problem as, 
after investigating the problem further, it's actually a bug in CGI.pm 
which has since been fixed ;)

My distribution comes with an old version of CGI.pm (3.15 from perl 
5.8.8). After updating to the latest, the problem went away.
