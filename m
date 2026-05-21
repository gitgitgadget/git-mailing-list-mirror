Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FB30567F
	for <git@vger.kernel.org>; Thu, 21 May 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404444; cv=none; b=rRmX+gTxmLWB4cibKUJJm3D4RXV+AxVgwHRobHpqYUfsbXTqaw1VZyoQqWKDdoMoT0K/JMj1009Qq2fTaQ53zK1RcofGm1edLFpElcyGNcuuKXlb+jpvPEkcs/szFtc4QyFWu2DnpJHhAR+Ya5eCO/X8bkqORaelusxcTtyKZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404444; c=relaxed/simple;
	bh=Fb2WrywYfHe7Taq7suM1u/gTOzdA9I5/x9KTOXlE9CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pihHmdhua1nu39N5/bCNiHtxmQtQ5dlywRY5qmcOjaFVX2YIt9De9jtENPskhxmDz5NTc5WLoLUVuCJ0dM8r0r0wBkkAsu2ikrJmYv1bC7s+/2+fo+hYPXU7fIBnhEP81CYPG5xZ/b15I9UuImBaElkFLohXj9eR/24psSy65rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuWlJyV1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuWlJyV1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e63771d91so66698611cf.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404442; x=1780009242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RK2p4ITOOItjoJn+67wpZ2hy+l7wPMqT/uQKogXEZ0=;
        b=XuWlJyV1y1+pNOKKX0kpQyyPysDY0W6Dy45+cYXFcZMhlntbe3P7XQdUP4tb7xKbCl
         M8ysRJI7kKCnRSVb7qXYlE4U95/nCXaqZyE8qeBivQtegSFv7e5aoAT8XkTyCWn5xBSO
         0E+NnUCKFeW4cbIkDogXZ+DrOT4eKlAaFbb8zol+dOZf5qScTrJtSfZnbHHqtmFsVcrH
         h+TNtBu3jGeGR0nLdMlpzF+Jbp2Fn82KnJVWLb3cuoGgXpjGwM9/BCnir0ZRCg1wWdAO
         6HwYETUvxQTzUjuaU+4VV7fwV+U1kClKJced21fl3Ga5iOiMWufOXWrLg/q0Tqj7v3ob
         VmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404442; x=1780009242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RK2p4ITOOItjoJn+67wpZ2hy+l7wPMqT/uQKogXEZ0=;
        b=XPt0TdAsgfmxBrAy6PCU92EhIR6mV0dk/yzwbb6txdCx6dXqqPzynepRmt9FZ4IAkZ
         al/IAdqP6C2DQ926NelWlBA9lVDvX/KJeCv1fPItDHo7DhJgQ42qkNmK4XZTSTVELyUe
         DVWvd+HTUMjx2Fec4oQLP5h30+MA0eWTXdA+GQR4dp+vafUSB0TiRbGuzaisNmuVHCF6
         /hqQqQXhNAqXWyopEdZKAIDaXNp++rV2h6ztWC+ShpPg7qFWDDsOe5FjLqUNbIvUqoFZ
         OxDayCq+8PzIkREcNn6OVxfD3Pim3rj99RMZB9DEYilqRsWQ9AM5lKjsXXA/bDc7sQ35
         Y/+w==
X-Gm-Message-State: AOJu0YxA/+6UOxdCc2KFWHVgC4XFHsJxLkyuXvmPfpyXHtaflb1r9NaL
	fbSIEXmwqUBIfi/zxTOufaawpZXTr7K9nQvUwuxCFWGOeonmrdLHiYlN
X-Gm-Gg: Acq92OE1fLScver5d4HNYNq4nNh3tdPPrkGG17nEdj5b9i5NwilEJ0nMjPcNKJJSLY/
	5n95z7gJ6lcgCq5C2AHJDo5+IZDCQN4/0hGwC+dKmh5dMHRa6b/fE7he4oX4g+ZpwE/LQmFdaFg
	hyK0LcjRezdM6GzLnuMdezLhsU8vBI9EA3IDP2B/XycZlAPxCXbTdyJ0rfiDwFfXTJS7WVmb9xP
	P/jvpUjiAYFinmRZK5kyi1PrISFD21FCiVynzVC6WMGHm9iqmcIf3xdFCt1W4OElBclh1RBqVeJ
	FUDF7lR5F5cPAMYDc3Y2nwYcmDdE+1gpyXlcYi2DHnsEO2+PP/jsd/ACL6/WvQjl9BScqNwBJCh
	uzsAN2cjCbBm/FxAWY63wymKSyEXnAAeEAqjdQZASjIl2wQ1ePYcyVDuMP/A60VB7Zu4z5b0t4i
	SF81rUF3roRlyeewmqxy72DMp9kptei3ABkeQi3lYLEFt6qnNtPNPWutk2ZGPG5QIpshL6t0hJe
	My+9BVOprIwXVDeZ+4/ozfB+ifwF1oRfZxvDyKvCwepqrcB
X-Received: by 2002:a05:622a:418b:b0:50f:be4f:465e with SMTP id d75a77b69052e-516d466fb5dmr20623511cf.53.1779404441887;
        Thu, 21 May 2026 16:00:41 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:b19a:969:106e:4f95? ([2605:a601:9b88:8300:b19a:969:106e:4f95])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e269csm803716d6.25.2026.05.21.16.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 16:00:41 -0700 (PDT)
Message-ID: <53d46614-7d9d-49ab-ace7-71367f6d2f40@gmail.com>
Date: Thu, 21 May 2026 19:00:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] path-walk: always emit directly-requested
 objects
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <e77c8a6bbc22da3428751f81ff5ee79aa5364237.1778707135.git.gitgitgadget@gmail.com>
 <agzwsxV2KEkkaGPV@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agzwsxV2KEkkaGPV@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 7:22 PM, Taylor Blau wrote:
> On Wed, May 13, 2026 at 09:18:46PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/path-walk.c b/path-walk.c
>> index 6e426af433..05bfc1c114 100644
>> --- a/path-walk.c
>> +++ b/path-walk.c
>> @@ -248,6 +248,17 @@ static int add_tree_entries(struct path_walk_context *ctx,
>>   	return 0;
>>   }
>>
>> +/*
>> + * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
>> + * were directly requested by 'pending' objects rather than discovered during
>> + * tree traversal.
>> + */
>> +static int path_is_for_direct_objects(const char *path)
>> +{
>> +	ASSERT(path);
>> +	return path[0] == '/';
>> +}
>> +
> 
> Hmm, I still find this a little brittle. I think that 'path' here is
> doing a number of jobs: it serves as a strmap key, it's visible to the
> caller, and now also a "direct object" marker.
> 
> Could we instead store this explicitly on the type_and_oid_list, e.g. a
> "direct" flag? I'm not sure whether that type has the right scope for
> this information. If not, I wonder if there is another way to store this
> information, since I worry that future callers may not know about this
> convention and end up changing the result of the path-walk depending on
> how they name their paths.

I don't find this as fragile as you do, because these "direct" paths
_need_ to start with '/' to avoid collisions with other paths that may
exist _and_ this meaning is internal to the data within the API. Callers
can't change this data, though they will see the paths themselves in the
callback function.

And as I mentioned before, this is a memory-efficient storage of this
indicator bit because it only consumes memory when it is "on" and the
vast majority of cases where it is "off" it doesn't take any extra
storage.

Thanks,
-Stolee

