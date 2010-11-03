From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Wed, 3 Nov 2010 23:58:42 +0100
Message-ID: <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:59:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDmIS-0006PC-7L
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab0KCW7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 18:59:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab0KCW7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 18:59:05 -0400
Received: by fxm16 with SMTP id 16so980201fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=fOZ69sOVKrTKGUIt7Qs+/VtfWDWtFF9lrUlolyvGN3k=;
        b=bTgu5X74JEgp7g6UM2L9wFdSWXTB242LcIS395a1igVceRBU7TH5c+KxU0PwRr8N8K
         tR6fjXiWSqeNRn/h9K9ZS4iyrOQm5EpKzquT3sm7QUEOmU+6nPpq/2fczPIs+Ge5hjC4
         cWFwMOOyHMLsqPlkTX10OG98oCXuJiflbZq+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=vnstdIvu+IJLGcYUussbj3uWx5wW9MnASTdGAFDkDBR+WxfHFfodzWsddahRFev9JF
         AFIkw3nrwjfbNKdjG7mL/fQ7g/hc98GyaZGcjEbqRl7VJzKpJNkJh8Owlc4+cyocdJhc
         ZKOLI9QxkbNdMSu2LUo+HwIixyLph9zSyL7O8=
Received: by 10.223.114.202 with SMTP id f10mr134195faq.67.1288825142866; Wed,
 03 Nov 2010 15:59:02 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 15:58:42 -0700 (PDT)
In-Reply-To: <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160648>

On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
> <patthoyts@users.sourceforge.net> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>>Here's hopefully the last iteration of this series. The previous ver=
sion
>>>only got a single complain about a typo in the subject of patch 14/1=
5, so
>>>it seems like most controversies have been settled.
>>
>> I pulled this win32-daemon branch into my msysgit build tree and bui=
lt
>> it. I get the following warnings:
>>
>> =A0 =A0CC daemon.o
>> daemon.c: In function 'service_loop':
>> daemon.c:674: warning: dereferencing pointer 'ss.124' does break str=
ict-aliasing rules
>> daemon.c:676: warning: dereferencing pointer 'ss.124' does break str=
ict-aliasing rules
>> daemon.c:681: warning: dereferencing pointer 'ss.124' does break str=
ict-aliasing rules
>> daemon.c:919: note: initialized from here
>> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break s=
trict-aliasing rules
>> daemon.c:675: note: initialized from here
>> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break =
strict-aliasing rules
>> daemon.c:682: note: initialized from here
>>
>
> Yeah, I'm aware of these. I thought those warnings were already
> present in the Linux build, but checking again I see that that's not
> the case. Need to investigate.
>

OK, it's the patch "daemon: use run-command api for async serving"
that introduce the warning. But looking closer at the patch it doesn't
seem the patch actually introduce the strict-aliasing violation, it's
there already. The patch only seems to change the code enough for GCC
to start realize there's a problem. Unless I'm misunderstanding
something vital, that is.

Anyway, here's a patch that makes it go away, I guess I'll squash it
into the next round.

diff --git a/daemon.c b/daemon.c
index 6eee570..d636446 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1159,14 +1159,13 @@ int main(int argc, char **argv)
 	}

 	if (inetd_mode || serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer =3D (struct sockaddr *)&ss;
-		socklen_t slen =3D sizeof(ss);
+		struct sockaddr sa;
+		socklen_t slen =3D sizeof(sa);

-		if (getpeername(0, peer, &slen))
-			peer =3D NULL;
-
-		return execute(peer);
+		if (getpeername(0, &sa, &slen))
+			return execute(NULL);
+		else
+			return execute(&sa);
 	}

 	if (detach) {
