From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git_getpass regression?
Date: Tue, 3 Jul 2012 18:28:11 +0200
Message-ID: <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net> <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net> <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
 <20120630183607.GA19739@sigill.intra.peff.net> <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:29:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm5yE-0004jO-4v
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 18:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182Ab2GCQ2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 12:28:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62172 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab2GCQ2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 12:28:52 -0400
Received: by yenl2 with SMTP id l2so5466076yen.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4PeAWmUraRrkN9HWtE87I2g/XITWw28FA05yt0El9h0=;
        b=AX+MPHfoIYUNb3Xawv0RFOyxKNZKGgeFjeWUxPw1tG7Ulw/QFbmbztHizTXBrGMHik
         vR15WJqwJvLjZSjOpYFj7xPHd9/28UBZrzLS98uiStatEmAmBmAzMrbChssr216Gfscd
         PzqFnyWhMPcd1xH4OuRSyApds7qzHY0iPGo7CqgvMuItRIRypcYI9ScSiekB1kjzV6vY
         BC4OX4n+i/T+yrMIo5WqTurJ6rAazwxiMtnu4TiowhBWjk7IJdYyEOTR+SQ+VdXxRYGX
         5K2bGYMTDqKfoFIDz6IZthW7hsZCp5DxHhyg6zPdQpdpEWQFIYTSB5VFB0FUJl257mdr
         EglA==
Received: by 10.68.197.70 with SMTP id is6mr8420119pbc.64.1341332931723; Tue,
 03 Jul 2012 09:28:51 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 3 Jul 2012 09:28:11 -0700 (PDT)
In-Reply-To: <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200916>

On Sat, Jun 30, 2012 at 10:15 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> On Sat, Jun 30, 2012 at 8:36 PM, Jeff King <peff@peff.net> wrote:
>> On Sat, Jun 30, 2012 at 01:27:09PM +0200, Erik Faye-Lund wrote:
>>> + =A0 =A0 if (!echo) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 hconin =3D CreateFile("CONIN$", GENERIC_R=
EAD | GENERIC_WRITE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FILE_SHARE_READ, NULL, OPEN_EXIST=
ING,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FILE_ATTRIBUTE_NORMAL, NULL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hconin =3D=3D INVALID_HANDLE_VALUE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(input_fh);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(output_fh);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 GetConsoleMode(hconin, &cmode);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!SetConsoleMode(hconin, cmode & (~ENA=
BLE_ECHO_INPUT)))
>>> {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(input_fh);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(output_fh);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> The HAVE_DEV_TTY version takes care to reset this on signal death or
>> premature exit (so if you ^C out of the program, your terminal is no=
t
>> left in a funny state). You might want to do something similar here.
>>
>
> Good point. I'll look into adding a Ctrl+C handler routine that clean=
s up.
>

Actually, it seems the shells (at least CMD.exe and MSYS bash) sets
the console mode to something sane when the process exits, so in
reality this doesn't seem to matter much. But I'd like to play nice
with the system if I can.

Adding a Control-handler that simply restores the console-mode only
made it behave slightly worse for me. A control-handler in Windows
runs from a separate thread *without halting the other threads*.
Combine that with the fact that the IO-call returns EOF when Ctrl+C is
entered, the result is that the calling thread and the Control-handler
thread race to restore the console-mode. The result is a correctly
restored terminal, but with a sporadous "could not read"-error based
on who wins the race.

But there are more gotchas: Ctrl+C is sent to all processes that share
the console on Windows. And it seems that Bash actually terminate it's
child-process when it receive Ctrl+C! This can happen *before* we even
get the Ctrl+C handler in our process, preventing us from restoring
the console mode. Luckily this doesn't seem to cause any harm, because
Bash seems to set a sane console mode itself.

Is there some other way of getting EOF from the console than Ctrl+C?
If not, perhaps we can disable the Ctrl+C handling altogether for the
current process, and restore the console mode on EOF? That only leaves
the "Bash kills our process"-case, but Bash seems to set a sane
console mode anyway.
