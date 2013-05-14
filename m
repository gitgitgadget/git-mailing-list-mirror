From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] branch: show me the hot branches
Date: Tue, 14 May 2013 16:34:03 -0700
Message-ID: <7vip2ldtlg.fsf@alter.siamese.dyndns.org>
References: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
	<CABURp0rVoRwWUBXP5ZdsPByd47hDj7w9y5eddNQfiDfkttAKvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOjo-0004Xz-BA
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab3ENXeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:34:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab3ENXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:34:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B0E1F164;
	Tue, 14 May 2013 23:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a50r9uL6P+P9A0Gt9jSNwIQeu3A=; b=pbfrpd
	9fMSDWAKhd6YJJzffuV/LNloV9bpZP0OVxvs6LJKHzrfZygiWL961RWE6zMYSgGb
	LZQOQR+4jdPU/48uNGZz0p7ibJ6zAg6mseH/OtpmffFqhMiWHJjWD34dnUY3SndC
	2ZR0WYlQtMOCytie2W60Ez+9AE4Ew+3v9lzAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PcdvwyisZ9XV9K4icJ3rbO6wvPoOntrX
	QTHmG+bZJeEJ8XMZLTKDCWbLMqJS7+Kk6xp9BZ7t/lnUvruoAPK0qeir2j845BOS
	6bQAzdCBJCQdHy/hTvmC4r/Z5bullMkLPg9L1Zo68gtwoOLEeKIgEOfv4W4kmYoM
	p3JZKu3dEY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9973C1F163;
	Tue, 14 May 2013 23:34:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FFD91F161;
	Tue, 14 May 2013 23:34:05 +0000 (UTC)
In-Reply-To: <CABURp0rVoRwWUBXP5ZdsPByd47hDj7w9y5eddNQfiDfkttAKvg@mail.gmail.com>
	(Phil Hord's message of "Tue, 14 May 2013 19:19:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4042604-BCEE-11E2-BA05-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224372>

Phil Hord <phil.hord@gmail.com> writes:

> I imagine it with --date-order and whatnot.

Perhaps modeled after this one.

    git for-each-ref \
        --format='%(refname:short) %(subject)'
        --sort='-committerdate' refs/heads/
