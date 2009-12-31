From: "Kirill" <kirillathome@gmail.com>
Subject: RE: [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 17:42:05 -0500
Message-ID: <000701ca8a6a$7c002070$74006150$@com>
References: <1262289470-4208-1-git-send-email-kirillathome@gmail.com> <a5b261830912311312if3d71aax5bb693a907dc5c0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, <msysgit@googlegroups.com>
To: "'Pat Thoyts'" <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 23:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQTiv-000307-O7
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 23:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZLaWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 17:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZLaWmM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 17:42:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:49056 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZLaWmL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 17:42:11 -0500
Received: by qw-out-2122.google.com with SMTP id 8so1370531qwh.37
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references
         :in-reply-to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding:x-mailer:thread-index:content-language;
        bh=9Li/SJ0rB++2TpOdRxyRt97xo9JPjT8a7uJmzBe6nMo=;
        b=xm4rnW8ooVFrdU9GjQAogcqMtt/5f6+7OQ2vzGMwoULQADQ3tJD2VuFcPpypxru2cX
         wvV1zMGw82kUYipVdi5fkRKdh9kON7M1OZLz4Vqb4PRzPlJUoUaCEpbRD8NfWNrz2i16
         cEZkZsoI05hJWAaTEbGDmH8F59mmxNDbTO424=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        b=v2wpA8go9O9Ty0AaHaovDOop4UGJVEe/Y1SrOM3VOlbScU3AxMorLOrsNes/FRPtf9
         SKiRcLi+ikNbdiYL/az9Sxq+bQpUUo0Ec1GI6qpk+82lozIQu+yYW1p0uirLybfDL6Ct
         UJrfnGuQpzu5x8TK7DRvLJZvc74pkqN0NhsBM=
Received: by 10.224.106.3 with SMTP id v3mr9460892qao.243.1262299329812;
        Thu, 31 Dec 2009 14:42:09 -0800 (PST)
Received: from midget (ip69-17-233-41.vif.net [69.17.233.41])
        by mx.google.com with ESMTPS id 22sm13516169qyk.6.2009.12.31.14.42.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Dec 2009 14:42:08 -0800 (PST)
In-Reply-To: <a5b261830912311312if3d71aax5bb693a907dc5c0f@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcqKXe+bKq6es3tyT4uN6xx9JUHvFgACWUDg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135980>

Unfortunately, I have to insist on my patch :)

> -----Original Message-----
> From: Pat Thoyts [mailto:patthoyts@googlemail.com]
> Sent: Thursday, December 31, 2009 4:12 PM

> 2009/12/31 Kirill <kirillathome@gmail.com>:
> > Looks like 37871b73 by Giuseppe Bilotta does not work very well on
> > Windows. Instead of a former tcl/tk icon, the window has a black
> > square as an icon.
> 
> I've been using versions of gitk on Windows with that patch since it
> was applied in March and it has been fine. On Windows XP and Windows
> 7. So there is more to this than you are telling. Are you using
> windows via remote desktop?
You're absolutely right about *unintentional* withdrawal of facts in my original message, but no, I'm not using Remote Desktop. However, my XP SP3 has 16-bit colors and apparently 8.5.7 can't display those photos correctly in this case either. Most probable reason why the issue was first discovered in Remote Desktop is because most of RDP sessions are limited to 16-bit colors.

> If so, this requires an updated Tk and not a patch to gitk -
> tk 8.5.8 should be ok if this is the problem.
Unfortunately, the situation is improved with 8.5.8, but definitely not resolved (tested on msysGit devel branch). The sequence image create photo && wm iconphoto on 16-bit displays in XP SP3 renders the background black, not transparent. The fact that I'm using Classic color schema may play some role too. I'd speculate that 8.5.8 on Windows 7 (admittedly, it's much harder to switch to 16-bit colors there) may have exactly the same issue, given that 8.5.7 has exactly the same symptoms.

Is there a way to replace the "simplistic"

if {$::tcl_platform(platform) eq {windows}}

with something more elaborate that takes into account 16-bit colors?

--
Kirill.
