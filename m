From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] attr: do not attempt to expand when we know it's
 not a macro
Date: Sat, 27 Dec 2014 18:59:30 -0500
Message-ID: <CAPig+cRp-UJSuQv=GrhL16LZudjTf_8grZrZk-dNc7PHcHSHmg@mail.gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1419723588-13236-1-git-send-email-pclouds@gmail.com>
	<1419723588-13236-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 00:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y51Gq-0007ZP-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 00:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaL0X7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2014 18:59:32 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:38866 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaL0X7b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2014 18:59:31 -0500
Received: by mail-yh0-f47.google.com with SMTP id f73so5826215yha.6
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=XVEkFVy52nYPYmzvArAaFvfM6lBZ29i3yO6DNEDgVGU=;
        b=YXm7CZjUdZHDBexNM+o+3UJDPMthEmTzQoPhkp1JxXx2FtirXZ88LeFkmZL0qLTL5C
         HicE6it5gF5Wn4KHQ9jkogrU3rurl7Rk+rgWuDwnBshTeLd0lKxhBiFJ2vAoCT92s/f0
         xqyczWCb6iRdc+espSVS00mqL5oZchQ9NJvkv2PJpdlPNvWXa/B8CLb1dx6jXxeimrGa
         z1E4ooUCUtCERbgZBtQcHgzS65FPCRhSqo6SiEYpJbFHovJUM1bx6Y2I5gREHi2VFPjH
         I8WUo+XyV3dcDNnIKPE6mLi3KdZTF5LRcSVir+nc+CgZBfYgfh2iQi/Qlxe2BE3THPFa
         PUmg==
X-Received: by 10.236.14.36 with SMTP id c24mr34656887yhc.166.1419724770547;
 Sat, 27 Dec 2014 15:59:30 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sat, 27 Dec 2014 15:59:30 -0800 (PST)
In-Reply-To: <1419723588-13236-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: oD3ku6Uuwfqs_CciPwTRUY87bIM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261846>

On Sat, Dec 27, 2014 at 6:39 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Keep track of all recognized macros in the new "maybe_macro" field.
> If this field is true, it _may_ be a macro (depending on what's in th=
e
> current attr stack). But if the field is false, it's definitely not a
> macro, no need to go through the whole attr stack in macroexpand_one(=
)
> to search for one.
>
> Without this, "git grep abcdefghi" on git.git hits the inner loop in
> macroexpand_one() 2481 times. With this, it's 66 times.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>

My only contribution was pointing out a typographical error in the
commit message[1]; hardly worthy of a Helped-by:.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

[1]: http://article.gmane.org/gmane.comp.version-control.git/261177
