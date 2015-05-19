From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Tue, 19 May 2015 12:34:03 -0700
Message-ID: <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 21:34:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunHI-0005p1-1S
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbESTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:34:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33198 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbESTeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:34:05 -0400
Received: by igbpi8 with SMTP id pi8so115497368igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VS44qMR7I6xibTMhXe42O07Q5qNz2Y1WyszDvhg8jSI=;
        b=yCl4IlwVKuXrWsIikxS13KL1oEfADuZDt3qymSpxW+HFBHVdYqxzdHuSmG9OpPuI4j
         kOUZNpPDI97synoKl3Ov0aPaI++UzE2wptrSTgp6xjSZ4LkrR80hYf80Vl0f8HHPhwRa
         md57jiESgzpuCxhAn+mDPwg4wlM+iMARJA8ftQv/rlIss5KWfFg0qDWcaIe19lApur8A
         95wB5dnqzRVBK9+A2UPBngupyz/k2QoKWP0LL7BSXX+mA8masVLwJD8HllNfQS/rMzrQ
         VEE2+bieVaZ9i57Nv/bJB3KSuy4kDfoWLYAj1Qa6e+PQmXSakb5jTcwQ07cyZ0eJrUpZ
         Mcbw==
X-Received: by 10.50.178.230 with SMTP id db6mr23531813igc.26.1432064045092;
        Tue, 19 May 2015 12:34:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id k37sm10632303iod.39.2015.05.19.12.34.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 12:34:04 -0700 (PDT)
In-Reply-To: <1431845814-2541-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Sun, 17 May 2015 08:56:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269392>

There still are a handful of "pack-file" remaining in the
documentation set, even after applying these three that changes
6 instances of 'pack-file' to 'packfile'.

git-index-pack.txt:'git index-pack' [-v] [-o <index-file>] <pack-file>
git-index-pack.txt:                 [<pack-file>]
git-index-pack.txt:	instead and a copy is then written to <pack-file>. If
git-index-pack.txt:	<pack-file> is not specified, the pack is written to
git-index-pack.txt:	<pack-file> is not specified consider using --keep to
git-unpack-objects.txt:'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
technical/pack-heuristics.txt:    <linus> Anyway, the pack-file could easily be denser still, but
technical/pack-heuristics.txt:    <linus> In particular, while the pack-file is then compressed,
technical/pack-heuristics.txt:    <linus> Anyway: I'm not even trying to claim that the pack-files
technical/pack-protocol.txt:  update-request    =  *shallow ( command-list | push-cert ) [pack-file]
technical/pack-protocol.txt:  pack-file         = "PACK" 28*(OCTET)
user-manual.txt:[[pack-files]]

A quick "git grep packfile" vs "git grep pack-file" inside
Documentation/ directory indicates that we seem to use 'packfile'
primarily in the lower-level technical documents that are not
end-user facing.  Almost half of them are in the release notes
that we won't bother "fixing", so it might make sense to go the
other way around, consistently using "pack-file" that may be more
familiar to end-users.

What do others think?
