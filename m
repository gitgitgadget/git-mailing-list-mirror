From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 10/26] wrapper.c: allow to create an empty file with write_file()
Date: Thu, 18 Feb 2016 07:49:17 +0700
Message-ID: <CACsJy8AQKfJoq6qcOoiay79zGKn1F3s=fnsdbBxbHyJRir-LfQ@mail.gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com> <1455629367-26193-11-git-send-email-pclouds@gmail.com>
 <xmqqpovvgeca.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 01:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWCn3-0000I1-Kz
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 01:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965662AbcBRAtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 19:49:50 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32948 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965354AbcBRAtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 19:49:49 -0500
Received: by mail-lf0-f51.google.com with SMTP id m1so22524475lfg.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W/D0ZZ4/4rNlYYSYBAzMyF+wZPnDob5fJgkayFit+A0=;
        b=WieK5TW8fDA7LXaHgWFqVOYK2RHxkIN3R+xCOKDW1wC4MzXgyvVt3bqxKnqGCeDmxI
         e29+UPtwkN075sx8n9lbTeoRWEVC5y/Nowuhm4OyC04GOaFd1oenOqeNR7QddScOjElY
         E7owwnAE0Oi3bR3i5BehYg3NqZvyEHuk4SQ69ybAo9MqEUekRHzs3JJZXOihI8O63d4W
         JL850wCLi/0nTE8o3zX6/L8UX6H/G2aC53PQgIPLIoqs537+9omi8Kr+vLiK+A0IW2ql
         +SUkZj8kQckJm1ORoolJstIodS/objhFISDB+ZK9D3ZJKNILblMI4OTsYV6UYyks1O4Z
         dJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=W/D0ZZ4/4rNlYYSYBAzMyF+wZPnDob5fJgkayFit+A0=;
        b=DGiBtIjZ5Ktp+EzqcBHr45RulcTyKCSUuBiX8EpYwL8W15Q8PGTP3WsV683WV2K58P
         U/5rdQ9A2IGd0Q25nKfriuOe2D6fo7brAsONUSZSvst7Qh0sbzMx+NGfMAlcZvngHO8o
         SWjHTVRPd3VY+A0ilWFTKvIPLQ7eX/r3trBjVVzyRemNkYG2rkzun4x/fdpzOWdQqQKJ
         q6QBXFq2rAvo1YTYVj1LXXy30lxeU+DE6Cu/84P1mItXQoXaONvyGNxe03pjD1+0qSBK
         hPdRByoBhC/1nXxVzV7sHtSjFmgtWZ75gQRuRFM/wGQlpnjaYQIekjGTUykB15sUq9CL
         qrnA==
X-Gm-Message-State: AG10YOQ3SfHZRIeisBq6BWAkjmDSJZG2OZzqE8uSmI/uEYmUWT8nw34ZoyPRdCb5lKLEQP6gPlWfQ1w4HAWUOA==
X-Received: by 10.25.5.6 with SMTP id 6mr1644037lff.3.1455756587700; Wed, 17
 Feb 2016 16:49:47 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 17 Feb 2016 16:49:17 -0800 (PST)
In-Reply-To: <xmqqpovvgeca.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286570>

On Thu, Feb 18, 2016 at 5:29 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This is used later on to create empty .git/worktrees/xxx/locked when
>> "git worktree lock" is called with no reason given.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  wrapper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/wrapper.c b/wrapper.c
>> index 29a45d2..1dc1eff 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -666,7 +666,7 @@ static int write_file_v(const char *path, int fa=
tal,
>>       }
>>       strbuf_vaddf(&sb, fmt, params);
>>       strbuf_complete_line(&sb);
>> -     if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
>> +     if (sb.len && write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
>
> I do not quite see how this change relates to what the log message
> claims this commit does.  write_in_full() returns 0 when called with
> count=3D=3D0 just fine, no?

You're right. Somehow I got the impression that xwrite() was called,
but it's not in this case.
--=20
Duy
