From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 18/25] t5500, t5539: tests for shallow depth since a
 specific date
Date: Mon, 15 Feb 2016 14:17:58 +0700
Message-ID: <CACsJy8DE063TDsS3NGOTf5=tYpNTusX+ymDT8XG_RVjbqCW=Fw@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-19-git-send-email-pclouds@gmail.com> <xmqqio1y7v5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVDQY-00036g-21
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 08:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcBOHSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 02:18:30 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36248 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbcBOHS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 02:18:29 -0500
Received: by mail-lf0-f53.google.com with SMTP id 78so83262270lfy.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 23:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Jt2lP2pgkv++fDsgsmYeofyjfQCfg+xfJVfsjdRDGso=;
        b=bg2EieU3k+FC8CtoDs9Mdcj+ET5LkJn8MosIlh+Ty7XvicmW2yxE0k2eXD9YrQvkQc
         kAdGR4ObdWi8vlGWZKgOFSj9ulxygQy7l984CP756mZP0k2BEhXAnS1BhQCVpuUfJD0D
         KwKoxD6Z0bLBale3OFpfBxAMcrqe6YsBbeYgT+/zTvbPA+VVrT58+h7uPgIP5TRmIBal
         NivC742Z66WRCxa2pgQqlt1wt2iclFUma0tH7FhRq9idsXTyhG4qiIpzl2bm/Eq3JdIA
         HNtCzMYjhVskU0+uiGbvc5qso0UFtefO7K90hwHEti7M6Fh3Pc6ND3kGL4lKO0WKm30b
         vltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Jt2lP2pgkv++fDsgsmYeofyjfQCfg+xfJVfsjdRDGso=;
        b=nMZKSulL/cbNGDmKrqqON1uUsWF7DXngc31iBVVG5rGuUXHUq5T0vTZG8c44eMucuB
         CGQTUKKb45ST7C0DXTSHyy32RtPQN0k4zL39JeI1MK5QWNRiXMwP4pGejaB1suqibsje
         KGPJr78yZnfn1/Z63R1A9y8ye9lz96QkN5/4ww22E1/X+OVnIBFaj4C4AX+Cy1bDEvK8
         xKGUE0G+ARFN848FiZJUjTLSgpHzrYMUfJFRH+pcM4ZqdY/9Zk2J4GXj4TS23kP8TL5x
         YIX0pwqZs9oNZ8UYtY47GMEMxe5oLVAb/v+nd7ofB6hksS7u5hPzwZHna6Om9ALv3Qm0
         z6Xw==
X-Gm-Message-State: AG10YOTFYp25iyRJrBy6db1ob+HzKryr8nvIlW+h0UPuYw3qt0V0SEmn3vxf3GF0wB/DWSSk1KXVNQB5EbzovA==
X-Received: by 10.25.161.144 with SMTP id k138mr6094407lfe.83.1455520708043;
 Sun, 14 Feb 2016 23:18:28 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 14 Feb 2016 23:17:58 -0800 (PST)
In-Reply-To: <xmqqio1y7v5n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286176>

On Tue, Feb 9, 2016 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +     cd shallow-since &&
>> +     GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empt=
y -m one &&
>> +     GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empt=
y -m two &&
>> +     GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empt=
y -m three &&
>
> Didn't --date=3D"@10000000 +0700" work?
>
> Not a complaint but genuinely curious.

Nope. --date sets author date, but rev-list --since only cares about
committer date.

>> +     git clone --shallow-since "300000000 +0700" "file://$(pwd)/." =
=2E./shallow11 &&
>
> Are we required to add TZ to --shallow-since, or we merely tolerate
> if there is one (I am hoping that it is the latter)?

Hmm.. I'm not familiar with date parsing code. I was sure that the
parsing here (to timestamp) is the same as "rev-list --since" done on
the server side. The function used is approxidate() which seems to
ignore timezone.

>> +     git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
>> +     echo three >expected &&
>> +     test_cmp expected actual
>> +     )
>> +'
>> +
>> +test_expect_success 'fetch shallow since ...' '
>> +     git -C shallow11 fetch --shallow-since "200000000 +0700" origi=
n &&
>> +     git -C shallow11 log --pretty=3Dtformat:%s origin/master >actu=
al &&
>> +     echo three >expected &&
>> +     echo two  >>expected &&
>
> test_write_lines perhaps?

I was lazy. probably could go with cat <<EOF.
--=20
Duy
