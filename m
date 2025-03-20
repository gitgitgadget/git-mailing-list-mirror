Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CB15A8
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501916; cv=none; b=ZyeykB8MB8VsOfXU8dBqAT43EXJLoPRYRtLPQGAumClmekB4ol5WzRBn3+pbfc3kFfPSLvukXeei/1CZnshAir5CHrTm+N+ZhhJm+tPv35ee6XzERi/+EQchWZFhymdkf+uqBWq38pUggynp+5ZoRkbbwxFvvtVOGP5jYEGmFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501916; c=relaxed/simple;
	bh=q81UqyN5asyZ9g9AWQobzgkFOJqHHfZEysTBAo+v3wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYd/DBLTfWsv2gYZsXiUoZZBqOip+Wkw+KOkbLo06Cv96sLhjBsLNyeFTLx9/l7V4axDDimSt761PtGAYptdF+PbSI0hSuQY+4HTO1QXhuhtRIAtyoKdw4rrP5gYuyXJnnINYUIOMZHUX6kjUL7opfBq4q4jWrtxR/b3n//8pB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCLAmDPO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCLAmDPO"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efe4e3d698so11996257b3.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742501914; x=1743106714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMUInmQJgP2rBESLL5Nh66Ku7ocXql70V/yJm5o76TU=;
        b=eCLAmDPOM/YRT1ZeIK08kwpXJC8vdG4zalcwZ/N6ZI/njxrPpF3agEg/k1VgYsN8h6
         mr8nc3VwxRn/Q74fh3fCTE+17C0XK72+eIUcTWWn0btcNqg6/MXKwQdvycnCu+OQ8rte
         fKTnAml53Qy6IMqCmNUVOK1TZ4Hg9hkrTQuVV4qC+MaOFiz9whaKBKyoJBjDlg3/BRLK
         CXrHt64jKWM7WO4+gkjEI5OOrH6gP9DPursGTocbT00ZELx7Qpnh2gOirnT+xVmAoWlg
         9TROWeD5ulQjtcEMq0wVvh2hn9PBIOO4E4gZwxoFGYqRaOB+vvbPp100armJymKZMCaV
         3YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742501914; x=1743106714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUInmQJgP2rBESLL5Nh66Ku7ocXql70V/yJm5o76TU=;
        b=AO/3ZiJLysMEBmPMAtjCegpy2udr3WFW04Ur/EsUCs7GMqfuAhbbmWXVg8IfGVqfYv
         MwwtZrfTJFKIFalmvELdNQRRDS2SR+NRu0sKy7PdcFId1YSFN6YBto3Fc/lStTB5IVQr
         MFi+0k7307sDMsI80sx3O1jz9YCx2Bug71EOe1W1GHPyovCkFN/anrSLFb9QGZFHdhR6
         yzIkaNzyuUHJgUKY/iiGMw9AtG0Jv7uJkSaIFJoq7ONbjWZDcBAjQEkxbMdG/k5DRZlo
         eg5mZ7vyl35+PdsVX00nyi0pOj6kp78hgYAWtawWe6NsRWa85T+Tnl50oTN3TCrlYFfU
         Bs/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbz/ayaE9B5xFyl7PYRftWjlnkJQm5B7e1/AF7tPbGoNSZd3+GFY2pX3FJmDwbRhxhUSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhwLRDYoV6bWpETyyAGDMX0lDy5/+KEtXyjw3vNeunN89AmsY
	s8PgyIgdl1PyXMg53G5GemBFJm06TdhB7d5W8QSgItMcruyBLr4S
X-Gm-Gg: ASbGncuDoJRIZiVuRdAvr6cEQywd9yiEUDh55RRRgCTmPqbNArWq+hf1xQJ+N4RHT8O
	wgD3b4g2aY8Uo5HQ9GbYpKlnjmt38KENNEA+2QBWNv9TsKnbZvgbbT8UQE2NvjooooFA7RMNCEk
	vwbFyfi0doYoxZ8ens7FlDtY3H4anl51b1Tk28wzc1fozNAOajm4mi0xSB2YxQFx0tADHuXw9IK
	KkVtLEaPV02BRyg8pFErUql6dn0arJTqAv4PYbB6raG564+pNJzlnGlGSfpl5YakR65wK22bik0
	DM1kEitFI5aTdy4URHS7//rEjs1bOnlri5XDMACldYwnMNfrLsV6bWfy2RyZXpWd3vtlDHKMokX
	NYkq4fptgXDYK9YnGQmyt
X-Google-Smtp-Source: AGHT+IEYUQ0RL8bw3XC24AUk0+qfGnUDRLMasFvq3PQ3JAzvLEnUATeho9PPuGClWM+dU3cuKPGJaQ==
X-Received: by 2002:a05:690c:368e:b0:6fb:b2a1:3157 with SMTP id 00721157ae682-700babfd346mr10354337b3.3.1742501913404;
        Thu, 20 Mar 2025 13:18:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f12b:82ea:4a0b:3183? ([2600:1700:60ba:9810:f12b:82ea:4a0b:3183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba8820desm802097b3.102.2025.03.20.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:18:33 -0700 (PDT)
Message-ID: <192714d0-d351-405b-9186-367c5212aeca@gmail.com>
Date: Thu, 20 Mar 2025 16:18:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, johannes.schindelin@gmx.de,
 johncai86@gmail.com, jonathantanmy@google.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <xmqqwmcw7q2x.fsf@gitster.g> <Z9Hy6Yk2XM1RCsNC@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z9Hy6Yk2XM1RCsNC@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 4:47 PM, Taylor Blau wrote:
> On Mon, Mar 10, 2025 at 10:28:22AM -0700, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In the above three examples we see some trade-offs between pack size and
> the time it took to generate it. I think it's worth discussing whether
> or not the potential benefit of such a trade-off is worth the
> significant complexity and code that this feature will introduce. (To be
> clear, I don't have a strong opinion here one way or the other, but I do
> think that it's at least worth discussing).
> 
> I wonder how much of the benefits of path-walk over the hash v2 approach
> could be had by simply widening the pack.window during delta selection?
> 
> I tried to run a similar experiment as you did above on the
> microsoft/fluentui repository and got the following:
> 
>     Repack Method       Pack Size       Time
>     ------------------------------------------
>     Hash v1              447.2MiB      932.41s
>     Hash v2              154.1MiB      404.35s
>     Hash v2 (window=20)  146.7MiB      472.66s
>     Hash v2 (window=50)  138.3MiB      622.13s
>     Path Walk            140.8MiB      168.86s
> 
> In your experiment above on the same repository, the path walk feature
> represents an 11.873% reduction in pack size, but at the cost of a 30.9%
> regression in runtime.
> 
> When I set pack.window to "50" (over the default value of "10"), I get a
> ~10.3% reduction in pack size at the cost of a 54% increase in runtime
> (relative to just --name-hash-version=2 with the default pack.window
> settings).
> 
> But when I set the pack.window to "20", the relative values (again
> comparing against --name-hash-version=2 with the default pack.window)
> are 4.8% reduction in pack size and a 16.9% increase in runtime.

You're right that I wasn't including data around the --window option in
my analysis. This option presents folks with the opportunity to add CPU
time in order to improve the possibility of better compression due to
considering more object pairs.

But it's also important to note that that option still works with
--path-walk, except that the --path-walk option is focused on improving
the quality of objects being considered within a window. There's also the
aspect that there are two passes (one path-based and one name-hash-based)
so increasing the --window size has a larger impact on the --path-walk
option.

With regards to the microsoft/fluentui repo, I had previously been using
an old clone using --bare. The size changes if I use --mirror as well,
since it will get the fork hint refs corresponding to objects in public
forks that are not actually in the core repo. This changes the clone size
as well as the repacked size.

(To save time, I didn't repeat the --window option tests for name hash
v1 as name hash v2 is clearly superior to that option in this repo.)

Cloned with --bare:

| Type         | Window: 10     | Window: 20     | Window: 50     |
|--------------|----------------|----------------|----------------|
| name hash v1 | 451 M | 1m 42s |       |        |       |        |
| name hash v2 | 160 M | 35.4 s | 151 M | 25.4 s | 141 M | 31.0 s |
| --path-walk  | 141 M | 31.0 s | 136 M | 35.7 s | 129 M | 49.3 s |

Cloned with --mirror:

| Type         | Window: 10     | Window: 20     | Window: 50      |
|--------------|----------------|----------------|-----------------|
| name hash v1 | 882 M | 3m 27s |       |        |       |         |
| name hash v2 | 584 M | 70.4 s | 554 M | 54.6 s | 530 M | 69.4 s  |
| --path-walk  | 548 M | 79.8 s | 523 M | 93.9 s | 507 M | 126.2 s |

Running on a slightly-larger Javascript repo with the same CHANGLOG
filename issue, I get these results:

| Type         | Window: 10     | Window: 20     | Window: 50     |
|--------------|----------------|----------------|----------------|
| name hash v1 | 6.4 G | 36m 9s |       |        |       |        |
| name hash v2 | 920 M | 7m 39s | 767 M | 5m 49s | 665 M | 6m 12s |
| --path-walk  | 834 M | 4m 48s | 697 M | 7m 39s | 615 M | 8m 42s |

> But these numbers are pretty confusing to me, TBH. The reduction in pack
> sizes makes sense, and here I see numbers that are on-par with what you
> noted above for the same repository. But the runtimes are wildly
> different (e.g., hash v1 takes you just 87s while mine takes 932s).

I wonder if it's related to threading? I'm using as many cores as I can.

> There must be something in our environment that is different. I'm
> starting with a bare clone of microsoft/fluentui from GitHub, and made
> several 'cp -al' copies of it for the different experiments. In the
> penultimate one, I ran:
> 
>     $ time git.compile -c pack.window=50 repack --name-hash-version=2 \
>         -adF --no-write-bitmap-index

There's also some strange things with my numbers because I'm not copying
the same data into multiple places but instead running the test on the
same repo. Thus, the "input size" is changing with each run and this is
probably a big factor in the larger tests.

So the order in my tables is left-to-right, top-to-bottom, like reading
a page in English. Thus, the short time for --path-walk --window=10 in
the last example is maybe a bit faster because it is starting from the
665 M from the --name-hash-version=2 --window=50 example. 
> In any event, it seems like at least in this example we can get
> performance that is on-par with path-walk by simply widening the
> pack.window when using hash v2. On my machine that seems to cost more
> time than it does for you to the point where it's slower than my
> path-walk. But I think I need to understand what the differences are
> here before we can draw any conclusions on the size or timing.

I'd be very curious to see if more folks have bandwidth to do similar
testing. My default mode is that I like giving users more options to
explore which may work better for them. 
> If the overwhelming majority of cases where the --path-walk feature
> presents a significant benefit over hash v2 at various pack.window sizes
> (where we could get approximately the same reduction in pack size with
> approximately the same end-to-end runtime of 'git repack'), then I feel
> we might want to reconsider whether or not the complexity of this feature
> is worthwhile.
> 
> But if the --path-walk feature either gives us a significant size
> benefit that we can't get with hash v2 and a wider pack.window without
> paying a significant runtime cost (or vice-versa), then this feature
> would indeed be worthwhile.
> 
> I also have no idea how representative the above is of your intended
> use-case, which seems much more oriented around pushes than from-scratch
> repacks, which would also affect our conclusions here.The push story is valuable, but I'm also interested in helping users shrink their local repositories in whatever means they are
willing to wait for.

---

Meta-response to your patch review: I have made adjustments to my local
branch in response to the points you brought up. I'll hold off on v2
for a few more days to give more opportunity for review.

Thanks,
-Stolee

