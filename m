From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Use work tree to determine if it supports symlinks
Date: Fri, 27 Jul 2012 15:58:49 -0700
Message-ID: <7vsjccyfo6.fsf@alter.siamese.dyndns.org>
References: <17699041.7b2cBoDgE0@mephista>
 <7vobn0zx5m.fsf@alter.siamese.dyndns.org> <3068717.2K7be5iONg@mephista>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sascha Cunz <Sascha@babbelbox.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutUn-0000P7-DH
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab2G0W6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:58:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2G0W6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:58:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D8588B6F;
	Fri, 27 Jul 2012 18:58:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RGbWqPlJqx5JAV0+2E7FfxQlxn0=; b=NHKalB
	AzTNl1nQjC3gqG4D7Sw5+mRDXeCO5Kp3hxAUI4CER47ldPqDWN4pxWKgAoM+cTND
	oYcDvXvj6ava3IP/Ns7HsuFgf27t6LXoidXjhtR3ZqAOuCoNYx+MIkg2lDgxC50D
	Po0Po2VcdQxtqDyapZkWHmAWRu6EacASpBBXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SqJ2hwO9Z3zXFqWDADnpdohe/OSEcZrF
	kl0I2sqKlgkx9CxCTCX6QgsOFbgB+9Wj27B+wYi+Mz5Ux25zKEDn8F8AYGu0wFTx
	fb9H3ngYcVKj0ix8Vkh8GZe7dZItoL9bp33pytzGSwEqMT4dN9rak2mP2myLnKsi
	mjHZweQawi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA5F8B6E;
	Fri, 27 Jul 2012 18:58:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0753F8B6D; Fri, 27 Jul 2012
 18:58:50 -0400 (EDT)
In-Reply-To: <3068717.2K7be5iONg@mephista> (Sascha Cunz's message of "Sat, 28
 Jul 2012 00:40:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1B4BFF4-D83E-11E1-9B30-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202391>

Sascha Cunz <Sascha@babbelbox.org> writes:

> Ok, so repository and working directory are simply not meant to be on 
> different file systems. Thanks for the clarification.

I did not mean "and that is a rule we need to enforce and keep
forever". I was just answering your (implied) question "why does
code comment, behaviour and documentation disagree?", to give a data
point that would be useful when discussing what the ideal behaviour
should be.
