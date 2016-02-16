From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 20:42:05 -0200
Message-ID: <CALMa68q+TgAXS0=xc1CpZ2nbzGb+TWafWCUXZhGrWPzFL5_AQQ@mail.gmail.com>
References: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
	<xmqqegccmikn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:42:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoJz-00027p-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbcBPWmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 17:42:08 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38157 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbcBPWmH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 17:42:07 -0500
Received: by mail-ig0-f171.google.com with SMTP id y8so1896056igp.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gFaigGicG0YLwo5TGUIJk6aLd27+J2cOe4979hVO8Es=;
        b=GhqM4N1VqPK3fd6iAm9ZlHVPn3vn0Jsndbn2hNMcD2czTx5/5LFNrkyW44BTOouHow
         QYR8EoZwNaUU2b/1NvKF+u8M/YM6iObqjGR+KuG4jcGO+EpixhTVwcnqc31C3UXvbbkg
         lWr+Q5PvtpzewtpF8bKoysHz3iywu7Wxnl5Ch+7nCVX9lFlqs9f4EmBuWr/vDOus1fGw
         euzE/muPDfy8bH4mtXGy/ZDHgRYhHt3FO2Z9kO2ZHIBf/pf87ZWGva0E7PkNP6C0eO8J
         VJhOh49rE0byvzcgNM4hUswhl2CQzvetIWWcCJB9J5H8fIsFKVXfmk16icImw8I9u8l7
         2AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gFaigGicG0YLwo5TGUIJk6aLd27+J2cOe4979hVO8Es=;
        b=fOET4GyQh14301Tg36rV6QVVb9Ic1k77df9dXH6B5loBvAOxpln3mqw5s+RoPUIqK9
         a3bM/uLYgbBfYkFoHwkufZ8Zwew9GDJpHaY6cDR7vOaARMjoA8TRuNNrNOpZzirs7kIN
         0LiY5Nw1L9nqmdw9YdTArqHQhaDlEy9+kGVOb8ok3GJka7mZcO1JZbLD25gZ9T26S6zj
         U4SXF/nV1NzNJhQvX+RFtR29k/v6HxM1vESGFo9aRxU/r+VKl5e0lt+h0A9rklC0XlZz
         LAuS0//YBST7LuAwNIrlV+dz0RdMA2AFG0IvQ4KqFZFgj+j27PDpJR11SKKA821ZUnTO
         4GSg==
X-Gm-Message-State: AG10YOTYQTb0TgxSseC/lsfJ7InocsOFUukBsNKGO3CC++9x6ABYa9eC6Uu6KWVGOM1lLmJUxHW/Y7GyLjbkeQ==
X-Received: by 10.50.43.199 with SMTP id y7mr21285698igl.47.1455662525569;
 Tue, 16 Feb 2016 14:42:05 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Tue, 16 Feb 2016 14:42:05 -0800 (PST)
In-Reply-To: <xmqqegccmikn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286446>

On 16 February 2016 at 19:49, Junio C Hamano <gitster@pobox.com> wrote:
> "Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:
>
>> +no-renames;;
>> +     Turn off rename detection.
>> +     See also linkgit:git-diff[1] `--no-renames`.
>
> Even though by default for merge-recursive the rename detection is
> on, if we are adding an option to control this aspect of the
> behaviour from the command line, it should follow the usual pattern,
> i.e.
>
>  (1) the code to parse options would allow an earlier "--no-renames"
>      on the command line to be overridden with a later "--renames"; a=
nd
>
>  (2) the description in the documentation would be headed by
>      "--[no-]renames", describes which one is the default, etc.
>

Just a note: In git-diff, there is no "--renames". Instead, renames
are enabled by the "--find-renames[=3D<n>]" option.

1. Do you think "rename-threshold=3D<n>" should enable renames?
2. Should we have an option "find-renames" in merge?
3. Should git-diff have a "--renames" option?

I personally like your suggestion as it is. Just wanted to make sure
you considered that while I work on the next patch.

Thanks,
=46elipe
