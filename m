From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 14:30:16 +0530
Message-ID: <CALkWK0m+okqJk05BMQAEMww6FNLxaLVhAM92WmUDeA_J-drOdg@mail.gmail.com>
References: <20120109223737.GA1589@padd.com> <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net> <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
 <7vipki7ix9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 10:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rku3F-0005lv-TD
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 10:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab2AKJAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 04:00:39 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39945 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab2AKJAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 04:00:38 -0500
Received: by wibhm14 with SMTP id hm14so181226wib.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tNMXa25BWHr/AbKHlnc/2/XMwuFxsLOhgCUslYfScDk=;
        b=F3xfgdhb3x8cJm242WorwZx6bwQrKMh3IYtZLjwmEcASjOw8KbHT5vHBxVrco9cSIp
         D+3iHXH7Vy/XojCREXVDbTlt70aHMKZkmOlm672zUZdkprroOonCIyaJ4P14CfWSC4/I
         GMdFM700uAUvGhJh/yhwwRZpO9xGQrcSzrlJ4=
Received: by 10.180.104.5 with SMTP id ga5mr9013773wib.21.1326272437286; Wed,
 11 Jan 2012 01:00:37 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 01:00:16 -0800 (PST)
In-Reply-To: <7vipki7ix9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188344>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>> If you then do a lookup for "foo/bar/baz/file2", it can use the exa=
ct
>>> same stack without looking for or reparsing the attribute files. If=
 you
>>> then do a lookup for "foo/bar/bleep/file", it pops only the entry f=
or
>>> "foo/bar/baz/.gitattributes", and pushes only the entry for
>>> "foo/bar/bleep/.gitattributes".
>>
>> I see. =C2=A0Thanks for the excellent explanation- =C2=A0I'll try im=
plementing
>> this scheme.
>
> I somehow have a feeling that you did not read the conclusion in Peff=
's
> message correctly. =C2=A0The code only keeps data from one active pat=
h of
> per-directory .gitattributes files to the leaf of a working tree and
> releases unneeded data (IOW, it "pops" the attr_stack elements) when =
it
> goes on to look at the next path, so my understanding is that there i=
s
> nothing to "try implementing" here.

My bad-  I thought the current implementation doesn't release the
unneeded data.  So, does the entire 7 KB of leaked data come from one
active path?

-- Ram
