From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] pretty: add pp_commit_easy function for simple
 callers
Date: Thu, 26 May 2011 15:47:29 -0700
Message-ID: <7v4o4hulj2.fsf@alter.siamese.dyndns.org>
References: <20110526222450.GA20077@sigill.intra.peff.net>
 <20110526222724.GA21775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 00:47:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPjLI-0000o8-LD
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624Ab1EZWro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:47:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab1EZWrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:47:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86B8A5FC2;
	Thu, 26 May 2011 18:49:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AaVU5RKrPzpZ4w3whB8VnUUDOGo=; b=fL19+p
	r8ZjjRMeJEZSX4lU2ya7jag6/yECFSGP5b88sefToaNxo8dqxaPPGNZLXF4UrRi1
	9aFSTg+dr1Ql3F8e7/qabdS3/4vukk1HDVFKMlBtBbPWkq/XHJLJLYHMQCXwWIb5
	NmvpFbS5y6yhqfzOIg+Jy6lXN9L36Z6l/3NFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQ6Az+Sdwa9vPd0SczRhOlCx/GyB2LW9
	kNCu064INT4NZmNvcgJt+6NAknWDlnnn07EiUxsdXZopP5+FQ9DcK03QkW5myZsu
	XSA6h1DxVUpz5YOIgju9JXfSt+gWaA906TZa1FFEXjnIcrSExFMycNnKPlq/2bH0
	aOVC+oWVXd8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53FA55FC1;
	Thu, 26 May 2011 18:49:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA85D5FC0; Thu, 26 May 2011
 18:49:40 -0400 (EDT)
In-Reply-To: <20110526222724.GA21775@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 18:27:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7430EE36-87EA-11E0-822B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174590>

Jeff King <peff@peff.net> writes:

> Many callers don't actually care about the pretty print context at all;
> let's just give them a simple way of pretty-printing a commit without
> having to create a context struct.

Very nice ;-).
