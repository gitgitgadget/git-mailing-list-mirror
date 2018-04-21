Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B625C1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 20:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeDUUpC (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 16:45:02 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:42911 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDUUpB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 16:45:01 -0400
Received: by mail-wr0-f176.google.com with SMTP id s18-v6so31139370wrg.9
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X9JvMIlozrzS3x0FUmOggUFzL5JMXv+rzYeWk1GZ03g=;
        b=b8QYdQhe0CFe4m2IUfwsxl5JCDd6Hp2uJY2kPKWQNhCQ8zJPQ9tc215l0DVv0Wo+Ke
         Vs9vs+lOaiWDzgxxnjs6NZBnVICtWi5ulaCdghuS4Xydn9n4dKpczSYS1E9yBV/1WMnL
         SYDP5Pc7yZMQXyQa/83CU+xpZ4EbYHfExQdl9xjiZZD6/sjYJuAoDmk/IXJWKOZA0Rkv
         SayiDPwJZxLA+0e/0C9sRHNLs6OoKzlsxXj3TIuFDpO4M45zMqJnu0NdK6M+9HmvPAhC
         PSBu8SM3WOzQSWcIQDt+bkz2WmcRZ/1PEEQA/Dl4Rb2xQ0gMdL7l3PfXtGDq3PibNPFX
         Ty7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=X9JvMIlozrzS3x0FUmOggUFzL5JMXv+rzYeWk1GZ03g=;
        b=AKGntYP/iWKEyLbATbfPxL/05q+yQ2Rc4neVc+aHdCjYbIsN/m4GlKFufHfpMry9ud
         eKHJgyBzth/N4a+JfTSY+uBD88/wSGsquV8RjhsLihEoofMCQAvZIqaHyUiGQzuLBNLG
         O9Qk1h59o3wDjmOL7sEOS0FW0Eo+Rv7Bu9ZfXVVcqn5OGX8Uen6LxB/k1f01PkgQvS8l
         ew6QLWQsKGIbCSgsgA1NusqYM3MLasywnvpbmdVuGkzCeY/Uo7beCwXVroWpLAjDPCAl
         eTSPKQVAf9GAKwUT3/CCoQPvgfgX768alaTdQg2vcmeulOhLrcERnQnqvfJl2rWZ65Wq
         bQqQ==
X-Gm-Message-State: ALQs6tCAimKyk8+3pn/uv0i57b/YgMU/EjHpbxf1y7EetHKpq/A8SH/I
        3NSFU1TqGBhwlvvwwir1ZMOmTwK7
X-Google-Smtp-Source: AB8JxZoHpNaZ0sn8nTZ4thiMSM8K2xr20wIR8Cg8ltZVfsN2CyYGvdqOLlBzzrMHlHoRtpJUuhBioA==
X-Received: by 10.28.136.199 with SMTP id k190mr5247961wmd.154.1524343499937;
        Sat, 21 Apr 2018 13:44:59 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id j21-v6sm11919272wrb.49.2018.04.21.13.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Apr 2018 13:44:58 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <867epjez1n.fsf@gmail.com>
        <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
        <868t9t5yjz.fsf@gmail.com>
        <45320265-9fec-cee1-e82c-3ff719bb0435@gmail.com>
        <86lgdplogn.fsf@gmail.com>
Date:   Sat, 21 Apr 2018 22:44:57 +0200
In-Reply-To: <86lgdplogn.fsf@gmail.com> (Jakub Narebski's message of "Sat, 14
        Apr 2018 18:52:56 +0200")
Message-ID: <86d0yscmra.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 4/11/2018 3:32 PM, Jakub Narebski wrote:
>
>>> What would you suggest as a good test that could imply performance? The
>>> Google Colab notebook linked to above includes a function to count
>>> number of commits (nodes / vertices in the commit graph) walked,
>>> currently in the worst case scenario.
>>
>> The two main questions to consider are:
>>
>> 1. Can X reach Y?
>
> That is easy to do.  The function generic_is_reachable() does
> that... though using direct translation of the pseudocode for
> "Algorithm 3: Reachable" from FELINE paper, which is recursive and
> doesn't check if vertex was already visited was not good idea for large
> graphs such as Linux kernel commit graph, oops.  That is why
> generic_is_reachable_large() was created.
[...]

>> And the thing to measure is a commit count. If possible, it would be
>> good to count commits walked (commits whose parent list is enumerated)
>> and commits inspected (commits that were listed as a parent of some
>> walked commit). Walked commits require a commit parse -- albeit from
>> the commit-graph instead of the ODB now -- while inspected commits
>> only check the in-memory cache.
[...]
>>
>> For git.git and Linux, I like to use the release tags as tests. They
>> provide a realistic view of the linear history, and maintenance
>> releases have their own history from the major releases.
>
> Hmmm... testing for v4.9-rc5..v4.9 in Linux kernel commit graphs, the
> FELINE index does not bring any improvements over using just level
> (generation number) filter.  But that may be caused by narrowing od
> commit DAG around releases.
>
> I try do do the same between commits in wide part, with many commits
> with the same level (same generation number) both for source and for
> target commit.  Though this may be unfair to level filter, though...
>
>
> Note however that FELINE index is not unabiguous, like generation
> numbers are (modulo decision whether to start at 0 or at 1); it depends
> on the topological ordering chosen for the X elements.

One can now test reachability on git.git repository; there is a form
where one can plug source and destination revisions at
https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg#s=
crollTo=3DsvNUnSA9O_NK&line=3D2&uniqifier=3D1

I have tried the case that is quite unfair to the generation numbers
filter, namely the check between one of recent tags, and one commit that
shares generation number among largest number of other commits.

Here level =3D generation number-1 (as it starts at 0 for root commit, not
1).

The results are:
 * src =3D 468165c1d =3D v2.17.0
 * dst =3D 66d2e04ec =3D v2.0.5-5-g66d2e04ec

 * 468165c1d has level 18418 which it shares with 6 commits
 * 66d2e04ec has level 14776 which it shares with 93 commits
 * gen(468165c1d) - gen(66d2e04ec) =3D 3642

 algorithm  | access  | walk   | maxdepth | visited | level-f  | FELINE-f  |
 -----------+---------+--------+----------+---------+----------+-----------+
 naive      | 48865   | 39599  | 244      | 9200    |          |           |
 level      |  3086   |  2492  | 113      |  528    | 285      |           |
 FELINE     |   283   |   216  |  68      |    0    |          |  25       |
 lev+FELINE |   282   |   215  |  68      |    0    |   5      |  24       |
 -----------+---------+--------+----------+---------+----------+-----------+
 lev+FEL+mpi|    79   |    59  |  21      |    0    |   0      |   0       |

Here we have:
* 'naive' implementation means simple DFS walk, without any filters (cut-of=
fs)
* 'level' means using levels / generation numbers based negative-cut filter
* 'FELINE' means using FELINE index based negative-cut filter
* 'lev+FELINE' means combining generation numbers filter with FELINE filter
* 'mpi' means min-post [smanning-tree] intervals for positive-cut filter;
  note that the code does not walk the path after cut, but it is easy to do

The stats have the following meaning:
* 'access' means accessing the node
* 'walk' is actual walking the node
* 'maxdepth' is maximum depth of the stack used for DFS
* 'level-f' and 'FELINE-f' is number of times levels filter or FELINE filter
  were used for negative-cut; note that those are not disjoint; node can
  be rejected by both level filter and FELINE filter

For v2.17.0 and v2.17.0-rc2 the numbers are much less in FELINE favor:
the results are the same, with 5 commits accessed and 6 walked compared
to 61574 accessed in naive algorithm.

The git.git commit graph has 53128 nodes and 66124 edges, 4 tips / heads
(different child-less commits) and 9 roots, and has average clustering
coefficient 0.000409217.

P.S. Would it be better to move the discussion about possible extensions
to the commit-graph in the form of new chunks (topological order, FELINE
index, min-post intervals, bloom filter for changed files, etc.) be
moved into separate thread?
--=20
Jakub Nar=C4=99bski
