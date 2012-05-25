From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 11:13:55 -0700
Message-ID: <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr> <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXz1W-0004J7-UW
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab2EYSN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:13:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950Ab2EYSN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:13:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D3985D9;
	Fri, 25 May 2012 14:13:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFiYY4S4+xPsMuLB5eE0wYZ7nL4=; b=M9tOmX
	WZkx3Q4D2vwCtsthSf+fh9BMY1pMsCLnrvgaINANpKBcjL/cCvVuIcCLbIW1LPKs
	lOAq5UPVX/SzO7mlAOfKRuox/MAZP+RBR5FNXI9Hr0/8fDYaIzaUHvxw6Hccp03z
	HJCo0CxHNbjDKKGfG7cIuYtPiAD91bif2VY7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNIQoqdS8V41X8wvsvWZWAZC0ENMF5VC
	Yke/M71si2s1XBNRxCySV99xX9qh1bmjWJUUPILlipslY4q63236wNqvsIemW4J0
	xCsix8MXRlvgMZYYkVV74QmhzchhKzviFDM3CTg+8XlTylmooWcjQdGdIWB35jle
	IQHBHNkbqWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3C385D8;
	Fri, 25 May 2012 14:13:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC1FA85D6; Fri, 25 May 2012
 14:13:56 -0400 (EDT)
In-Reply-To: <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com> (Hilco
 Wijbenga's message of "Fri, 25 May 2012 10:31:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64D74BB8-A695-11E1-B490-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198501>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> This is, of course, highly OS dependent. Ironically, I'd say we need a
> setting in .gitconfig for it. :-)
>
> There is also /etc(/default|/sysconfig|)/git/config to consider
> (perhaps for some settings that should be the same for everyone).
> Better yet, it would be nice if at least some settings could be part
> of the repository itself (whitespace handling e.g.).

As long as we make sure we have knobs for distro packagers and people
building from the source to twist so that they can easily name the places
they want us to read from and write to, what we decide in-tree does not
matter.  We default to ~/.gitconfig and /etc/gitconfig as before, and that
is perfectly fine.  We already have ETC_GITCONFIG, so the only thing it
might be nicer to add is the build configurability of ~/.gitconfig file,
no?
