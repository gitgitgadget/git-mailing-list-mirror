From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Thu, 31 Dec 2015 01:08:43 +0100
Organization: Opera Software
Message-ID: <5684720B.40208@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
 <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com> <5681D02C.1040609@opera.com>
 <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
 <CACsJy8ADrHW=Tr2Tx04NoAKP3MfP__Ndjut_G_7HitLPHKn46w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:09:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQo1-0005wx-DT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbLaAIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:08:48 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35905 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbLaAIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:08:47 -0500
Received: by mail-wm0-f51.google.com with SMTP id l65so73323664wmf.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 16:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6MOolA7ykpVZLcqTLRoCjZk9iVf0SLeZ+bo5PxDdNak=;
        b=TeQo4JQWhWdJhjYQ/Wm9kYqgtqB9TRYXME0q1IKF7mzmzdNmnwpTMjq+qPVbEYxA60
         C3dfpPoAj4V7n5c6FqyBcMQK8wW5e5rrm+Jf/PEMCUvCKiMS1NE4nHCF86p/7qSVbXzP
         VVriU0hNDQ+UB7v0f2dyU4GzUCraB8tYNfwxHTkuOnN0Jpe7Kzy+kB7oJvOY8N0QPtq4
         +si9afY+ll0+qho6KDPtZ/PmsrXaFNP3T2MMt7/jAvUN3JHnDh5f0ccEaS/zq5RXw2zT
         vPtYPSXPqRGCJ8U3DnNQHXL8ISOKm8ur355qk4B3dSVrSM9L30R9VQm9p3O/1/mVZ43/
         /VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6MOolA7ykpVZLcqTLRoCjZk9iVf0SLeZ+bo5PxDdNak=;
        b=iKKI0nIpnzhasgz1k+oyLoPwXlXkyvVgwXrWty3PSI0/H5a5CoZcgCuFnpKXEP03uI
         cVTY2A8Mqi2KLpkxUd6r7plV1W/275RXiONYcjX+vIVwHEitlDJ7zTxXeJpS2RmvBMDE
         9NQ+aMk74wnfkRfAkG3w1xwh74zhvCTalhG3hKxLaw+mu2n5Oi/h14vxuFbBN2PV5rbq
         HeCRK1hCGc0ZdQVeFuwZhgjCAWitMYIcAacG3Z4acG9llZBWs883NXzWiueIGJUP70FV
         UfwPxK3NDeCguHzvRTIfNAagU2CNXwEeF910WhshL63XY30gol+qHPc4vmAFQQXb9q1F
         LhQg==
X-Gm-Message-State: ALoCoQlijyhRN+6A6BAlbqrs3AwhybUoX89Tn9NasuoBdJIPiGceH7fJWViuP2dMiP3Q/K180hARyikpN8sSmuGLCNoKd0240A==
X-Received: by 10.194.220.233 with SMTP id pz9mr82232626wjc.95.1451520525673;
        Wed, 30 Dec 2015 16:08:45 -0800 (PST)
Received: from [10.0.0.50] (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id s2sm12134063wjs.43.2015.12.30.16.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 16:08:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CACsJy8ADrHW=Tr2Tx04NoAKP3MfP__Ndjut_G_7HitLPHKn46w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283220>

On 12/30/2015 10:52 AM, Duy Nguyen wrote:
> What about not using command line options? We could go with something
> like pathspec magic. I think as long as we provide three options:
> literal, some pattern matching and backquote, then the user has enough
> flexibility to specify any set of refs. For pattern matching I'd
> prefer wildmatch. regex can be used via backquote, e.g. `for-each-ref
> | grep ...` (or teach for-each-ref about regex to avoid grep).

I don't think that would solve my immediate problem, unless git 
for-each-ref knew how to produce output in the same order that git 
describe searches.  But perhaps I misunderstand what you're suggesting 
with the backquote/subshell.


-Mostyn.
-- 
Mostyn Bramley-Moore
TV and Connected Devices
Opera Software ASA
mostynb@opera.com
