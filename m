Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F8B1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfEPBqW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35532 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfEPAbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:31:35 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hR4J0-0006Vo-TH
        for git@vger.kernel.org; Thu, 16 May 2019 09:31:30 +0900
Date:   Thu, 16 May 2019 09:31:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190516003130.racexnofe7cxra3t@glandium.org>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 07:56:09PM +0900, Mike Hommey wrote:
> Hi,
> 
> I started getting a weird error message during some test case involving
> git-cinnabar, which is a remote-helper to access mercurial
> repositories.
> 
> The error says:
> fatal: mmap failed: Bad file descriptor
> 
> ... which was not making much sense. Some debugging later, and it turns
> out this is what happens:
> 
> - start_command is called for fast-import
> - start_command is called again for git-remote-hg, passing the
>   fast_import->out as cmd->in.

My mistake, it's the opposite: start_command for fast-import is called
with the out of git-remote-hg as in.

Anyways, patches incoming.

Mike
