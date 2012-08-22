From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 14:54:45 -0700
Message-ID: <7vharu6196.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
 <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
 <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
 <7v4nnxld24.fsf@alter.siamese.dyndns.org>
 <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
 <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
 <503519B3.1020403@kdbg.org>
 <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>
 <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
 <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de>
 <7v628a7iu5.fsf@alter.siamese.dyndns.org>
 <004501cd80a9$d01ecc00$705c6400$@schmitz-digital.de>
 <005201cd80ac$4cd414b0$e67c3e10$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4It6-0005vU-5w
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab2HVVyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:54:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343Ab2HVVyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:54:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CA4B9552;
	Wed, 22 Aug 2012 17:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6N9gWT7vmGV4GwErvRH1xN6n+ZE=; b=adKo4+
	G2b9TNBBfx/xEiV16p6ELDK0RtsRmjA3dIcrwwJ2ORPPlMETENT/gNifMNNFilW/
	Ei4NquLg1FnqiHjf8vNHAkQ5rMachOBdkxupqOYd9rJBleIIhAuFgyy3lRkStgxl
	ZdK1SpGC+1Zz/0YnGHNil8xGsGfvOJFZtZ9nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oP1QXGF/Z7OwPEChhpKYfZpJvo6uNnob
	K2nPoYtqz6yoDodcDLdqtPY2wW77tCAeXurx4qGsBJKq/mIhA0tC+Sbu/hsWI1bw
	KDAN1kX03Ws7lUGLRvU5H6OVs+NS6/Bey93aEHM8q5k12WfFEIOjD5yoh4BOaTyK
	vBHGGgJwMlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1933C9550;
	Wed, 22 Aug 2012 17:54:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73C14954F; Wed, 22 Aug 2012
 17:54:47 -0400 (EDT)
In-Reply-To: <005201cd80ac$4cd414b0$e67c3e10$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 23:22:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD822E9C-ECA3-11E1-A7D6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204103>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> I thought of having the function decclaration in git-compat-util.h, just
> like for eg. setenv, gitmkdtemp, etc.

Yeah, that's also fine, especially if you do not have to declare
structures and constants.

Once you start having to declare other things in order to declare
the function missing on the system, it won't be like setenv where a
pair of #ifdef NO_SETENV/#endif just surrounds a single line.  At
that point, a separate header file to hold them together would
become easier to read.  It's a judgement call; we'll see how it
turns out (we do not have to get everything right in our first
attempt).
