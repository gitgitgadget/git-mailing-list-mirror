From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 11:41:01 -0800
Message-ID: <xmqqoapy1pki.fsf@gitster.dls.corp.google.com>
References: <BBE88A3EA44D47159C483F1046AC747E@black>
	<xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCla-0004wD-4H
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbbAPTlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:41:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755782AbbAPTlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:41:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF17930A9B;
	Fri, 16 Jan 2015 14:41:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAfOR8dGItJF9cxaePBW+XivbGc=; b=vFPEMn
	AO4FjvivtBljwYOT9hnhWG8UtOk3LgyA5iLY/fxp3NqsmeafWvAAheCMZlXZ/h9C
	LoUZ4uG1a+R4tgqG0jxzOE4aKkLpjTdQwwLWfWbG8I6AUKUCfngl/rdlwuoZpHbr
	jTiTTWcRJOPNfUvEGkGhuin8S+vONAvFKsIl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOPODbxycmH5HkAI0TanFXuORV1fFjUM
	D+WmWjM1YW50QM8OU9vJwASaoM3g7hfcsvKoGpLIsUo6Emhgv2j3155Czq+PBmPn
	ZlwW4p7MRWWDqV56Cki+Dq+ljl3cR1Nu8fJpyd3evNNjVvXtREbBSA896g1JO5Rg
	oVEg/sOCTTc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C49BC30A9A;
	Fri, 16 Jan 2015 14:41:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33F2830A98;
	Fri, 16 Jan 2015 14:41:02 -0500 (EST)
In-Reply-To: <xmqqsifa1px6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 16 Jan 2015 11:33:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A5BC73E-9DB7-11E4-BDEB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262566>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if you need these unsightly backslashes.  When you
> stop talking to it after saying "$(", or "$( git cat-file ... |",
> the shell _knows_ that you haven't stopped what you want to tell
> it.

Ehh, s/stopped/finished/, that is.
