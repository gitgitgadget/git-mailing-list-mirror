From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/7] Add API for string-specific memory pool
Date: Sun, 30 May 2010 18:52:55 +0200
Message-ID: <AANLkTikiuFeGkDizLTmB_3AQgiU9vL3C_Tgxg_lf4LgL@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-6-git-send-email-artagnon@gmail.com> <20100529113800.GA7925@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 18:53:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIllP-0008U1-8b
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 18:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0E3QxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 12:53:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36012 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab0E3QxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 12:53:16 -0400
Received: by vws11 with SMTP id 11so1207517vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9PiZ3vIbjW4N3tMZ21FKwTep/jFv/tW034Y4t2WL8mY=;
        b=T5X0k/fUJ83GRyg1GGUH9h8liu8yCKam55jJy1eHkpRKft4DEkSxKYKNkgKa6fDMxp
         RroTqy/TdkTex49/V9YXQQD2ZKUmTRWJwqvg1gW4jlnzNXhmtPB5VTS4FvudFza336A1
         93xafDV1HBmKxXk240ykVKm1L8kXL6N5fUOxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w/yb9KwuZwzpvpQgV+dTY9gIQiWCJ6/Jqe154Eo37szNWlRSCS1/nZiWqQnQcffMDF
         +GkYTVZpdAIWpAFSL01Kqyrk8JEI/3pqj1ViB/mD90htleSxsKUI63x0nUYnaGGi5Gzd
         gLUp/lmRnQuKuurzmOzT3NFXLahxMJry8vpC4=
Received: by 10.229.182.16 with SMTP id ca16mr479647qcb.88.1275238395117; Sun, 
	30 May 2010 09:53:15 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 09:52:55 -0700 (PDT)
In-Reply-To: <20100529113800.GA7925@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148010>

Hi again,

Jonathan Nieder wrote:
>> +static int node_indentity_cmp(node_t *a, node_t *b)
>> +{
>> + =C2=A0 =C2=A0int r =3D node_value_cmp(a, b);
>> + =C2=A0 =C2=A0return r ? r : (((uintptr_t) a) > ((uintptr_t) b))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0- (((uintptr_t) a) < ((uintptr_t) b));
>
> nitpick: could use fewer parentheses.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return r ? r : (((uintptr_t) a > (uintptr_=
t) b) - ...

Actually, this triggers a compiler error on GCC:
string_pool.c:34: warning: comparisons like =E2=80=98X<=3DY<=3DZ=E2=80=99=
 do not have
their mathematical meaning

-- Ram
