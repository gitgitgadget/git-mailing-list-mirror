Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12521FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 13:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdJ3Nii (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 09:38:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:57026 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdJ3Nih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 09:38:37 -0400
Received: from [192.168.178.43] ([92.76.242.15]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M92lh-1e19Og48Xl-00CPAc; Mon, 30
 Oct 2017 14:38:36 +0100
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <49b9e9e6-8aeb-9a14-9309-f9274fe13e7d@gmx.net>
Date:   Mon, 30 Oct 2017 14:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WAVp/q3Lk3YkeRN0fwK/cejAP3hGxh0Yh+cniE/fWxHEbFrvY45
 a2VFwWqcTjGFQ+UtFKXixoj9WgJ4WGA4uPC02gb5oPg6AQKAKSW/YkC11Bxw8K5/6WiSWdD
 BDQFRnaWHeQIImWwBlpm13dKKAxawFsWIfKORgWOGuWFI++yepY4tEiJPFdArEnsNBMn/oH
 30/PtJW258b6QmnaykfDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:riSdHkNNE7M=:9VGJpv7a2P6WeLybZ8IPtS
 dNzIrRMVAfQKuy4kWPtVb1KzGvezEkYopGl+jtpbdHu9RXQUF7lITYlu+V9IEoTs/EKri/i8R
 RwLnsRTMj9MZmtE0W36RgAhkYgivy5O+UFx/qx5VCISjcXIdbRHMReGGpMUCkrOhuCd+9YbX3
 CCB3u4s8uONC2Fu43kRhPXtWwcG7++HPyjSHh65OhcBDP61UglJJBNlVcm/subeMcwRixX33E
 GGamu2uwsDxOwnGwpKzrI7nrV21E/b3JumRI2OSPtnCivGxUWnFkPB7yNXRA4kCmq56/5i1u3
 u098oq5D/Mh3KRstYHsOFnnLjN50bbIv6DDGnZFLOIcVZaqxBlORzeZRDLNwiaYzHjaLtupnO
 CoH69QP1z0vK0xKazwPVYy7I3UD8oN8vri4GedC9Nlu9c6Y51Wev72X1ma6ptffOofLb8LAT1
 lGIiHWOt5eXj7boEb19Pj6YrnLdIOLat1042NL20mceu1PVdRSF25S23WjCFb14DsGxyUwaYh
 OnHfQVEw1r8p1UW6oZDLg9O90QIkw+Q3s1N9pl8BOvYcz04TPxQ+GXEWgd1FKt0i+YKV69z8w
 MCebNEPdcz8NizHqfqB+g/Ft0c6kAa5pmKANzX2VWu+m8ta4BD4ny4EGzXG7WBXSDuRztIC2d
 QUiTXkBspfO1biyMXamJZ8BvUjgSuvq9thYv4iI+vOkjYp4PYC0oxN6HHaOQqeTWoTxwj5S7+
 iEcp2DOSw/OsncM4/8ywZYyrlhoZTjXETESeMzQqKIh2LsAYQt6X/ZiVgRCiIO08I649A+PSj
 1937auunHlzqqLibc06X+pbwexQPRRhwMrby2SlPDWFefclog8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also just a minor in addition to the others:

> @@ -153,9 +241,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		WRITE_TERMS,
>  		BISECT_CLEAN_STATE,
>  		CHECK_EXPECTED_REVS,
> -		BISECT_RESET
> +		BISECT_RESET,
> +		BISECT_WRITE
>  	} cmdmode = 0;
> -	int no_checkout = 0;
> +	int no_checkout = 0, res = 0;

This last change is not necessary. You never use "res".

Stephan
