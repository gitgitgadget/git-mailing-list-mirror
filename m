From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git adds some text file as binary file by mistake
Date: Fri, 31 Oct 2008 01:29:16 +0100
Message-ID: <200810310129.16847.robin.rosenberg.lists@dewire.com>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com> <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com> <46dff0320810292332y34ea0daemde05b58572946497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:30:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhuU-0006yG-NW
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbYJaA31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 20:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbYJaA31
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 20:29:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:18128 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbYJaA30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 20:29:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D3BC08027F3;
	Fri, 31 Oct 2008 01:29:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKQ4X-clp0QX; Fri, 31 Oct 2008 01:29:23 +0100 (CET)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 1EB63800254;
	Fri, 31 Oct 2008 01:29:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <46dff0320810292332y34ea0daemde05b58572946497@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99540>

torsdagen den 30 oktober 2008 07.32.47 skrev Ping Yin:
> On Fri, Oct 24, 2008 at 9:30 PM, Ping Yin <pkufranky@gmail.com> wrote:
> > On Fri, Oct 24, 2008 at 8:54 PM, Michael J Gruber
> > <git@drmicha.warpmail.net> wrote:
> >> Ping Yin venit, vidit, dixit 24.10.2008 14:37:
> >>> So what should i do if i want it added as text file?
> >>
> >> You should give us more detail on the file ;)
> >> What's the extension, what's the typical content? It may be a simple
> >> matter of specifying attributes.
> >> Do ordinary diff and grep recognize your files as text?
> >>
> >> Michael
> >>
> >
> > It's just an xml file. I guess maybe there are some hidden characters
> > at the beginning. I will figure it out later because i have no access
> > to that file right now.
> >
> > Ping Yin
> >
> 
> I have figured it out. It's just because the BOM characters feff00 in
> the beginning of the utf-8 xml file.

The UTF-8 BOM is EF BB BF, (no NUL.). FEFF is UTF-16 BE (and the third
byte would be 00 for an XML file). I think git currently regards just about
any UTF-16 file as binary becuase of the NUL bytes.

-- robin
