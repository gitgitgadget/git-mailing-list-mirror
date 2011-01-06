From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log -p hides changes in merge commit
Date: Thu, 06 Jan 2011 11:43:04 -0800
Message-ID: <7vwrmhakdz.fsf@alter.siamese.dyndns.org>
References: <4D25F6BE.7010300@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavjx-00018d-Mb
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab1AFTnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:43:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1AFTnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FA5C3F0B;
	Thu,  6 Jan 2011 14:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ztqa9Ghxjex844BkwVn2XbTgFpw=; b=TAuGIX
	2SnIhqZycZlN9TXSeFVnsFnTD/s9E1Dm8vaI0eHCPME0cZgIBE8gc/k83V59cXvQ
	2gttjeNMhJTJ9Axqwrk4LB6urwG+eTe2UKZlV/7igwAa6PtitUJ6mXIPMhTnEphI
	0r2X4fbFBIkkk2hyaoJ1jIcVLxPIvp+O+ZuIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nLaQ2DrLe8WeEPSq1kKu3R1BuxfXw4WF
	wreqeV2FndfRG/vWaHKoCjVDNl0htNsPBL3ojGrzQiWAaZ6Cr31Pm6L+reKtVv9H
	arWSonajdtqtEol3dAdafLNihbXVi5MqXC6I0j9i3qRoVtxD1v2Mm3hnMCj2eQXS
	abJIfoK64WY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5ED1D3F0A;
	Thu,  6 Jan 2011 14:43:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B4883F09; Thu,  6 Jan 2011
 14:43:43 -0500 (EST)
In-Reply-To: <4D25F6BE.7010300@cfl.rr.com> (Phillip Susi's message of "Thu\,
 06 Jan 2011 12\:07\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4688FB08-19CD-11E0-B691-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164660>

Phillip Susi <psusi@cfl.rr.com> writes:

> It seems that adding -c or --cc to the log correctly shows the change to
> a, but why is this not shown by default?

Depends on the definition of "correctly", but perhaps you have a
definition different from ours ;-) The "patches" shown with -c/--cc are
designed to be different from normal diff so that people do not
accidentally try to apply them with "patch" or "git apply".

"log -p" omits merge commits by default because diffs of merges are mostly
not useful for ordinary purposes.  If you are trying to use "log -p" to
reproduce a (part of) history, perhaps you would want to also study -m
option.
