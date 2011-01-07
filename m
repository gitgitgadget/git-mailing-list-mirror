From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log -p hides changes in merge commit
Date: Fri, 07 Jan 2011 12:27:56 -0800
Message-ID: <7vk4ig5uib.fsf@alter.siamese.dyndns.org>
References: <4D25F6BE.7010300@cfl.rr.com>
 <7vwrmhakdz.fsf@alter.siamese.dyndns.org> <4D262B05.2060306@cfl.rr.com>
 <20110106210438.GB15090@burratino> <4D276926.2020407@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIuz-00019L-7s
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1AGU2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:28:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1AGU2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBFBA3B35;
	Fri,  7 Jan 2011 15:28:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mn5BDBc6BVDrSxjva91S+kJt+Ho=; b=GyzoUj
	i0yh7Y5eLNQ9+VeP32AeYRylVWXKPPXiaUoduaxZE5GSanMHAP2ZcojtKtvutllB
	olEjCtjH6s4zoJU3+FPSLqrk/Vp/PWA5RbTJtWz9fGFhQzHQC63tIb7iSsAAUFh2
	QzwQxsS9I5SXrz5Aq9sWYUd1qnj3Ao8M7bnoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ovPGgE/AYzEa12rb0PWEdEtNLGkcmI5Y
	bewnJGnAh8VROcO7sGwZ/ltltJvsqFp5kpM7k9hUy6TFAqEZmJU9qLnoImUKrJf2
	Sb9RZLg2hzm+QP3x/DeTJPXdcp+lYwMpSH6HSvixNmuJd1GnhbrW4JZFlJzh8872
	PAD8rfZDoQ0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87CFC3B32;
	Fri,  7 Jan 2011 15:28:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 764E23B31; Fri,  7 Jan 2011
 15:28:36 -0500 (EST)
In-Reply-To: <4D276926.2020407@cfl.rr.com> (Phillip Susi's message of "Fri\,
 07 Jan 2011 14\:27\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6CC32F2-1A9C-11E0-9A3B-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164757>

Phillip Susi <psusi@cfl.rr.com> writes:

> That does help me understand the difference between -c and -cc, but I
> still don't see why one or the other is not the default behavior of log
> -p, instead of opting to never show anything at all for merges?

Assuming this is about the default, the answer is very simple.  The
features to support -c and --cc came _much_ later than -p, and many people
have got used to the default behaviour after using "log -p" for a long
time.  It simply is rude to change the default on them.

As -c or --cc won't do anything special on a non-merge commit, you can
always say "log -p --cc" if that output is what you want to see.
