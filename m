From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: reduce memory footprint a bit
Date: Tue, 10 Feb 2015 10:49:38 -0800
Message-ID: <xmqq61b9wqil.fsf@gitster.dls.corp.google.com>
References: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
	<1423487929-28019-1-git-send-email-pclouds@gmail.com>
	<xmqqfvaec2cm.fsf@gitster.dls.corp.google.com>
	<20150210093041.GA30992@lanh>
	<CAHKF-Atr_ezupL02aW08S-6NGGLi55vHuVep1mQvOaQq0Xh=FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: matthew sporleder <msporleder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLFsX-0001Hm-8e
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbBJStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 13:49:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753401AbbBJStk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 13:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 032CC360B5;
	Tue, 10 Feb 2015 13:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2qjCFSeULyDp43wUCrfNQpC1U1w=; b=jrkwz+
	zsE+9mKoMItBPBu39ch8GI/JXC5iSqX/3mXpswVZyixzrF36cu0KDCKfcFjYGud/
	wrXg/n3vTk+bZj9xYX4xCkAkZekcuR7XnoRrYR6c9VAVUahGgnrbkgNJPhflpSQ9
	QVdNBtw/+anCnZy8nPCo9jopqABdQroZgGzaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=siLWdjKfFuka01cqKeFCU3M9x0d0GH5V
	t78v5gdvYqFcrVEN93YlHdmV4aVNhA4ietdiHIeHKK5f/XKBJDnSRGiAVhsVatse
	yJEDloyesXoX+3HLljDVoY/4pGSR2SAu0pPSPviwvAbjIRTuQPhPSLOa5/rEFKtJ
	5bLck60fgck=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE9F9360B3;
	Tue, 10 Feb 2015 13:49:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76500360B2;
	Tue, 10 Feb 2015 13:49:39 -0500 (EST)
In-Reply-To: <CAHKF-Atr_ezupL02aW08S-6NGGLi55vHuVep1mQvOaQq0Xh=FA@mail.gmail.com>
	(matthew sporleder's message of "Tue, 10 Feb 2015 06:08:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 913CA338-B155-11E4-AF38-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263641>

matthew sporleder <msporleder@gmail.com> writes:

> I'm having trouble getting this new patch to apply.

Apply the first one, replace all object_entry_extra with
object_stat, replace all objects_extra with obj_stat and amend the
first one.  Then apply this one.
