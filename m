From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin
 mas<tab>" if the ssh key is encrypted
Date: Thu, 22 Mar 2012 10:46:05 -0700
Message-ID: <7vmx78y1eq.fsf@alter.siamese.dyndns.org>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hong Xu <xuhdev@gmail.com>, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAm5X-0008Sx-ET
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab2CVRqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 13:46:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab2CVRqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 13:46:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4CBE730C;
	Thu, 22 Mar 2012 13:46:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rWvy3euTigiL
	gf2MbPCb1LJC1Gw=; b=c3jRBDui42z/wONIxVegCULARfaENyV7nMs9KvWgwdzw
	RBnvuQ2UqYD0x1gYSLS+j18RtSmk8R5iqZxceWpTsH1JLQGcAxP5InclWGnOcw57
	ys1mnebaKI2V1FBypwYjhnQNo+Hx19CCqDThbmwSzf0KaenSqoqoSRxped/Xbdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g4abLs
	eGV0iDxB0jmkivN1F3GudLY6DpI049jzw4gLsbqzUeSUXbKGlvbjCL19ZlyqdmWN
	a03e+P6nHOeAbwKNSXSNjqSMNl1S8xLSnEkps6tvC71f2c4G5Bpm9oA9Vk8Rfgd8
	phaBN5XV8SAaI+sGwq8I6BZ8GeYx7a26Ip6CI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC05730B;
	Thu, 22 Mar 2012 13:46:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43F72730A; Thu, 22 Mar 2012
 13:46:07 -0400 (EDT)
In-Reply-To: <4F6AFEC8.9090907@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 22 Mar 2012 11:28:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E72DD0EA-7446-11E1-9B5D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193670>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> Maybe git-ls-remote should learn --quiet?

I would rather think that the completion should ask for refs only when
dealing with local repositories, without going over network, whether th=
e
query involves authentication or not.

When given a repository nickname, do we have a good way for the complet=
ion
script to tell if it is local or remote?  "type -d $it" might be cheap =
way
to do so, or we could even do "test $it =3D ." to limit it really to th=
e
current repository.
