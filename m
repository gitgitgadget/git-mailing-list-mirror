From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 10:21:17 -0700
Message-ID: <xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	<xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
	<CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:21:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRO67-0003Nk-Of
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 19:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbbHQRVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 13:21:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33115 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbHQRVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 13:21:19 -0400
Received: by pabyb7 with SMTP id yb7so112679472pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ADRBCpzGNckO6B0IJA7YYmKn9NgLLejx87PGSsIVefs=;
        b=iUgQaZKQvhtar3QHmGSTGBaj+/vAD2IdRYDOZx3fB+OyAJpsyownz9xlUzN6Mn7v+Q
         YciSv80c5Zan4aiyPYo5t+GiztII80fiyKNX/YAG8050Zs91g3zousQyj40nwASH+/2e
         4CaGVjv1AOj8bfrdO7NVEnBTlcQpdComJepykLTKAp78Nawzay8A6jBgIYPakVO4KvDe
         ztVcP/0rG1pvxsU1FttCP2mZcwjac2xpLIZmhNTs4eBHcluKsxIPuoN82XQ69CATKrDl
         ScW8FcQkOIp6K1QPAImiHXCttoJhsw1bXxUjS72nQjrrDzXj3G0q9m/HPTQWGVBB5mk4
         6hcA==
X-Received: by 10.66.62.133 with SMTP id y5mr4704754par.8.1439832078741;
        Mon, 17 Aug 2015 10:21:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id hv3sm15256923pbb.83.2015.08.17.10.21.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 10:21:18 -0700 (PDT)
In-Reply-To: <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
	(Dave Borowitz's message of "Fri, 14 Aug 2015 16:55:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276060>

Dave Borowitz <dborowitz@google.com> writes:

> Ok, so let us bikeshed a bit further.
>
> Bikeshed 1.
> Option A: --signed/--no-signed--signed-if-possible
> Option B: --signed=true|false|if-possible, "--signed" alone implies "=true".
>
> Bikeshed 2.
>
> Option A: if-possible
>
> The possibly confusing thing is one might interpret missing "gpg" to
> mean "impossible", i.e. "if gpg is not installed don't attempt to
> sign", which is not the behavior we want.
>
> I don't have another succinct way of saying this.
> "if-server-supported" is a mouthful. I think Jonathan mentioned
> "opportunistic", which is fairly opaque.
>
>> By "strange", I was referring to the possible perception issue on
>> having a choice other than yes/no for a configuration that allows
>> you to express your security preference.

My preference on Bikeshed 1. would probably be to add

    --sign=yes/no/if-asked

and to keep --[no-]signed for "no" and "yes" for existing users.

Regarding Bikeshed 2., I do not have a strong opinion myself.

Thanks.
