From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Thu, 15 Mar 2012 20:46:43 -0700
Message-ID: <7vwr6lgqcc.fsf@alter.siamese.dyndns.org>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org>
 <CACsJy8A-W97Jd+8FOk1zWbDoTPb=RwO6Ck37O73v7DRrR+M5ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 04:47:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8O87-0006wo-6c
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 04:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031427Ab2CPDq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 23:46:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031281Ab2CPDq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 23:46:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C6577E3A;
	Thu, 15 Mar 2012 23:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XDrlwXNMg8o8AAxEI0TroL/dxsQ=; b=VC/6rv
	sTGMb6dZFNO2WCRBS74OcmmWaPkFIMgfpKgHXutOex7wvi8BorTnVwJ4PZ9AM9Kf
	RcYOlkRvIhNW1+J8PcvcPrfZNAtZUfsWqcCTOvOoczpzUK5+0Slc1ZexVsTz68Y4
	Z9Sh2Qc6FfpPEMMQ1Lr2V8+HzkqHUk/Sn2BvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lfqclcX3gZYGEnr8wuiGvxWa3Y6s3P45
	10ciEz1eLMETHM4xIUqurygn687t8K75fNHkeHoBnZYaBqQsnwOQtvRqkEjuNlH6
	OlaCivWt/g9k/mbvstKnvOEnUn7V/gfvLc2KdIDqJcN7zMTNgW+jhXrQ4s9f0sq2
	JcvyqEvfML0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 242437E39;
	Thu, 15 Mar 2012 23:46:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADF327E38; Thu, 15 Mar 2012
 23:46:44 -0400 (EDT)
In-Reply-To: <CACsJy8A-W97Jd+8FOk1zWbDoTPb=RwO6Ck37O73v7DRrR+M5ew@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 16 Mar 2012 09:24:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A64596F2-6F1A-11E1-BF5D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193242>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> What about remote helpers?

What about them?  Don't these foreign-vcs helpers generally create git
objects on our side based on whatever data that comes from the remote
foreign vcs anyway?

> Should we declare it's remote helper
> responsibility to validate all incoming objects?

It is nothing new that they must not deposit broken objects in the
repository, so I do not think there is nothing that needs to be
specifically pointed out.
