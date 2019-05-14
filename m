Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998891F461
	for <e@80x24.org>; Tue, 14 May 2019 03:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfENDBd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 23:01:33 -0400
Received: from mout.web.de ([212.227.17.11]:52931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfENDBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 23:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557802884;
        bh=zbCG1/02MjOLhbkbh7QzZCCqVR6jl30cH8RhO7MGzt8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LHh1UYjC2kB/lsTyUcRRnr0jfrar+nEaT3kamXm3k++HjxHPOpJyoan3cPGJ28wUw
         3sGbToutPkr8eWhgIOf21CHMY6+kF6HnrbG2+2VVJGrzF0GTaTsYNAxuN7NET+LmlV
         Du4keadNI/MGdUqrpRuOkV1dLc/MyPhHD0OXrOE8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Md4l4-1h8Ibu34YE-00IFvO; Tue, 14
 May 2019 05:01:24 +0200
Date:   Tue, 14 May 2019 05:01:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 4/5] fast-export: differentiate between explicitly
 utf-8 and implicitly utf-8
Message-ID: <20190514030123.atqguzxh4v55ydty@tb-raspi4>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
 <20190513231726.16218-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513231726.16218-5-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:8PITnAmE8fFv5EyZIt6bVggUY09w3/6xZOJlDXxjGXiMk6blugc
 IB02OVBCOQfJW86DI5/17gUlHHCSmVU7qq90QKA9WSy9j2Fq3aRTwbEQkQNYjjPoV8sJHJ3
 GMA4G1Xm59NQpwuuTDp9Qg+DIeU6WcwJZUT+tk2TKvbd7in59ZETMHQA5DxXomxV+8k7iI/
 kcbSuaHVu87ILVwY7gePg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ibdpGjqz3IA=:dMd/uWFcj2q4GmtmLOXtJi
 MziBw5XUXHjDXJfhIhmcpghJyl3cZaLabkJfc4HThwPLKu0OWc4G+TKA/rHBkdRaNyk4ihZPI
 GqMyydGq7PjpZuGp9ihnmthnsmsABbQOKYgmuBr37l9UodroxhgcGy9ilcPkqI+vM5FC18uzb
 xzEYImY0tDsCYsZkYRbStWY90HyDwnmK8EaltGZFhQmN3zm1IP50FBwPPOY0MTCm9xI0Pyg2w
 MkO7gVMpsQaYpqiZIjuSra9rKpZTeoDpYglLOfzpcwLLxqDG8IsEDNnfht5AgAMmtWINJDsS6
 6aTqO1DkUFJ/SufOikpnE/KHKu+EB6fLgqgi5rw751Je7dgrQdJUmMZ2mNgyFwAgxQvlyWovW
 KecSs6oF+3NbhRkLiRVjkM6MaDvdtFKaC56IdsRmpQvrbvWAjjaiDEYfuq3EyrefNncU+pD9n
 LEc1J1LIxReU7NFlPCsibvx8N9uF6o9Vs+lSppX0HobBaLUp1jJAjdmUylqM5iNSrs7+O8BWN
 b3a1khKDQp/428Igpujv+O6Vg7lvG2ppHLmf4xFaeI1JdB8HAquCB6z9teQxkKLdU7xaGmFUa
 xmQGfFAnkGH4r87oUOYI1PEI0C2RV99kHlP3FelXGEfPz051ZcsWqwqDL48TDlX0xAlhkZ11/
 ctdQ4FYVq2+HjJH7P8jjaqLrPV3Nf7P6j5xVkLVQWGL1jNAnjbOG/1Bf8qy5UAQdxYi+xBCCH
 taI634Q7CnwOCa0iIhT+T4TljB1xQcwmeFqK5h5Je9SeQirEDNdQLN0ZWmh+rbm57OtlX1YqX
 ms32t1jja8glfj4bfEKuDDNzTZKUg55fIt4h3DMz6bFy+5B0V5yED67NB3Eiz38Exdw3nnkzN
 ULou3gKbaeQYC9RyTbIjvwb0RC++bF2j0bTq9gZW/uTn3FmvueoSjqz4yTvFvX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 04:17:25PM -0700, Elijah Newren wrote:
> The find_encoding() function returned the encoding used by a commit
> message, returning a default of git_commit_encoding (usually utf-8).
I think "UTF-8" is preferred over "utf-8".
Unless it is a function name like is_encoding_utf8()

> Although the current code does not differentiate between a commit which
> explicitly requested utf-8 and one where we just assume utf-8 because no
> encoding is set, it will become important when we try to preserve the
> encoding header.  Since is_encoding_utf8() returns true when passed
> NULL, we can just return NULL from find_encoding() instead of returning
> git_commit_encoding.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/fast-export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 7734a9f5a5..66331fa401 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -453,7 +453,7 @@ static const char *find_encoding(const char *begin, =
const char *end)
>  	bol =3D memmem(begin, end ? end - begin : strlen(begin),
>  		     needle, strlen(needle));
>  	if (!bol)
> -		return git_commit_encoding;
> +		return NULL;
>  	bol +=3D strlen(needle);
>  	eol =3D strchrnul(bol, '\n');
>  	*eol =3D '\0';
> --
> 2.21.0.782.gd8be4ee826
>
