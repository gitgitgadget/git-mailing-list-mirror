From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: align new ref summary printout in UTF-8 locales
Date: Tue, 4 Sep 2012 08:31:03 +0700
Message-ID: <CACsJy8B_aUfg6Cs_23UyjoVwQGrkBtMUoqOBQLTSM2cC=KfR3g@mail.gmail.com>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com> <7vwr0aewlf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 03:32:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8hzx-0006G9-1a
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 03:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab2IDBb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Sep 2012 21:31:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55197 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab2IDBbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2012 21:31:34 -0400
Received: by iahk25 with SMTP id k25so4724121iah.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7XrAO5XMr0YY5LCtSAY9YXjJyiv+TU9FepTm3eQpb84=;
        b=d9xeQdQlyR910rOd5AivWIHpx36SNCYqqvN73nUGogmgK4sYepmzafylzHwg/KhPmH
         fEOicb/zGz4WNH0GOfPhdakT5iwVSU/oGvcvnQqu39kIV0qL0PKRzRt9k3BRuQn8Kd7S
         n3sPSwbgxiZHVxuFy7W/5ynjGcYTLCCz0cy3jhj2uUzmavNTTa1Bn7C61GAu68EhgPC9
         tahSxHK0p34qaxgc3cd0dZunLI04EcKWz3dOKqCG1Dhv/Tr5ccJXVu1E8P/9L6JkfDxE
         ITPtdWmJTwSWQzkMafckEqiaZGr3Mdj7Wpb9tSArOZtd6VHEnuj0xIqJPRJzoHTR4xv2
         dEeQ==
Received: by 10.43.45.200 with SMTP id ul8mr16487868icb.36.1346722293986; Mon,
 03 Sep 2012 18:31:33 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Mon, 3 Sep 2012 18:31:03 -0700 (PDT)
In-Reply-To: <7vwr0aewlf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204714>

On Tue, Sep 4, 2012 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> fetch does printf("%-*s", width, "foo") where "foo" can be an utf-8
>> string, but width is bytes, not letters. This results in misaligned
>> ref summary table.
>
> "but width is bytes, not letters" is a misleading statement.
>
> Be careful about three different quantities when talking about
> aligning on terminal output with monospaced fonts:
>
>  - How many bytes does the string occupy in memory?
>  - How many unicode codepoints are in the string?
>  - How many display columns does the string occupy on terminal?
>
> Note that some "letters" (e.g. Han) occupy two display columns, and
> you want to measure the "width" and compensate that for "bytes".
> Letter count do not come into the picture for the purpose of aligning
> the terminal output.

Hmm.. I did test with zh_CN.UTF-8 and it seemed to work. I'll check thi=
s again.
--=20
Duy
