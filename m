From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 14:43:51 -0700
Message-ID: <xmqqzis5ebxk.fsf@gitster.mtv.corp.google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbdnKMxrp_rQp7k-G6mveNYxES4XB-+2jh2e4+_RwPeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4aP-0003rd-2C
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbcEDVnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:43:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753191AbcEDVnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:43:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 094A219250;
	Wed,  4 May 2016 17:43:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DShtNTVvYjBlTkGxQpHPHksWDos=; b=Oyq6fZ
	67yqkRkoq5OSRMpCT0nfB334MeDQcLhyy+DOmVEBfxVlBjm7/xggkNqWjFhkNogN
	85L2cgjqmZHyxC2H/3DthQj/3Lqt0uCGt5gQnlSu8nqweZeNwtlfizwDbutvRSDw
	BK4eVqaTC4AmBIAS15YiazDkc/czLTdMkSH9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hjDJVMCLOjmcVNMRxNn3T+ebTrI2DbCk
	7TYSgyGgO3Rgbal0mmUq32JCzY3T9oHHnJEL3RVyDnvJXy7dehqbhvVgFEJfyM/+
	Kjv0w+7F4G6rM12gE/SxJ5dVZ0nSJOFSjns4fVYL9DE9NH1ATXk65Pz38OVm9Qlz
	YjJz3l29pXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0113A1924F;
	Wed,  4 May 2016 17:43:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7695B1924E;
	Wed,  4 May 2016 17:43:53 -0400 (EDT)
In-Reply-To: <CAGZ79kbdnKMxrp_rQp7k-G6mveNYxES4XB-+2jh2e4+_RwPeyQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 May 2016 14:34:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BC8E354-1241-11E6-A920-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293598>

Stefan Beller <sbeller@google.com> writes:

> (e.g. work tree for working tree?)

This was probably primarily my fault, not just because I've written
more than my share of documentation (compared to the code that
touched), but I was deliberately writing "work tree" when both "work
tree" and "working tree" terms meant the same thing.  Compared to
the length of the timeperiod, the newcomer who is now known as
"worktree" has only lived a very short period of time, so it is not
surprising to see remaining "work tree" in our documentation set.

I think some attempts like 06cdac5a (git-reset.txt: use "working
tree" consistently, 2010-09-15) were made to clean things up even
before "worktree" started to mean an entirely different thing, and
we shouldn't make things worse by adding mentions of "work tree"
when we mean "working tree".
