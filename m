From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH i18n 09/11] i18n: apply: update say_patch_name to give
 translators complete sentence
Date: Mon, 23 Apr 2012 18:33:22 +0700
Message-ID: <CACsJy8AQtsmC65SXXjR_=e5T+LF=WYHPFMvK5EUcV_ZYKQuOag@mail.gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
 <1334580603-11577-10-git-send-email-pclouds@gmail.com> <4F9434F1.9000900@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Apr 23 13:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMHWp-0001NW-5o
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 13:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab2DWLdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 07:33:54 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54270 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2DWLdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 07:33:53 -0400
Received: by wgbds11 with SMTP id ds11so2458092wgb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FtnY3Yob0x1sJg0v5bSMdCIVknQQSrPA/y8sEvXutMI=;
        b=Ys5ajWiYx6UNlhmbXdTWor+2awUybyQ/CTnMyteuWTcE6wmYtEdB4N5FjQmKGr0V7n
         HcdcqufZf2FElm4EL66dD3f4RPxBmUt6ZrFC5ZNtrqksRQQ/JgjNFGuSvclhOwgtcW93
         DQq/IaF3owXaPxIVgRgBJVbb+qBfeyu2AxYdWKYyevtZEYOXaQcJ9zjMQleWXfQ40Xj/
         erPPzOqXCCP2pQPEt5mqtyCkz7+hGw+xa+au+T/eQu2j2HvWtXNOrDFdF+pFCOPUhjmQ
         ZgO+vAr10vSZfJKUNnKe8uoLOqLg61TKb+MdduhKRALbI/j6MAyvdFa8cIH+ZIkiIX6K
         72Dg==
Received: by 10.216.132.169 with SMTP id o41mr9712872wei.121.1335180832533;
 Mon, 23 Apr 2012 04:33:52 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Mon, 23 Apr 2012 04:33:22 -0700 (PDT)
In-Reply-To: <4F9434F1.9000900@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196111>

On Sun, Apr 22, 2012 at 11:42 PM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On 04/16/2012 02:50 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wro=
te:
>> @@ -3551,8 +3555,9 @@ static int write_out_one_reject(struct patch *=
patch)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("internal err=
or"));
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Say this even without --verbose */
>> - =C2=A0 =C2=A0 say_patch_name(stderr, "Applying patch ", patch, " w=
ith");
>> - =C2=A0 =C2=A0 fprintf(stderr, " %d rejects...\n", cnt);
>> + =C2=A0 =C2=A0 strbuf_addf(&sb, _("Applying patch %%s with %d rejec=
ts..."), cnt);
> Shouldn't this part be:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&sb, Q_("Applying patch %%s wi=
th one reject...",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Applying patch %%s with %d rejects...",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnt), cnt);
> ?

Yes. Thanks for catching.
--=20
Duy
