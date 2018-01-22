Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F361F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeAVWws (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 17:52:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:51389 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeAVWws (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:52:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0MMqjCD033272
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Jan 2018 17:52:46 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com> <xmqqo9lljz3l.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqo9lljz3l.fsf@gitster.mtv.corp.google.com>
Subject: RE: [Nit] Lots of enumerated type warnings
Date:   Mon, 22 Jan 2018 17:52:40 -0500
Message-ID: <001501d393d3$b82150d0$2863f270$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK5UYNG42G2iB87sMsXQlQ4bGvQ7AJJscQ9oaK2N6A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 22, 2018 5:41 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > I'm seeing an increase in the enumerated type warnings coming from my
> > use of the c99 compiler for compiling git over time (loads more for
> > 2.16.0 compared to 2.3.7 when I took it on).
> 
> What exactly do these "warnings" complain about?  Without knowing that,
> the remainder of your question cannot be answered.
> 
> Does it complain against enum FOO {A,B,C,} saying that the comma after C
is
> not kosher in older C standard, for example?

Here are a few examples, there are more:

auto_crlf = git_config_bool(var, value);
  		          ^
"/home/jenkins/.jenkins/workspace/Build_Git/config.c", line 1147:
warning(272): 
          enumerated type mixed with another type

type = sha1_object_info(s->oid.hash, &s->size);
  			     ^
"/home/jenkins/.jenkins/workspace/Build_Git/diff.c", line 3618:
warning(272): 
          enumerated type mixed with another type

options->color_moved = diff_color_moved_default;
  	                     ^
"/home/jenkins/.jenkins/workspace/Build_Git/diff.c", line 4108:
warning(272): 
          enumerated type mixed with another type

options->color_moved = 0;
  		                     ^
"/home/jenkins/.jenkins/workspace/Build_Git/diff.c", line 4218:
warning(272): 
          enumerated type mixed with another type

