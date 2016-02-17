From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/20] lock_ref_sha1_basic(): use raceproof_create_file()
Date: Wed, 17 Feb 2016 12:44:28 -0800
Message-ID: <xmqqr3gbhxsj.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<77c2b6f72b55943a0097d81196f520a7fe890310.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW8xf-0003WX-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 21:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbcBQUoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 15:44:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030267AbcBQUob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 15:44:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4484443D9A;
	Wed, 17 Feb 2016 15:44:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DHB6/2HA5D8E9uSeX+5GnWkCja0=; b=GKSv1l
	t3cMz4wLZutTkZhXI0us4Oz1DDHKQUcl8dsXVkQEoIEOSNSIR+EicE3vF04mvo1K
	Tse+jgyWyumKyDopH809VSAuLHvffS3WorNEP8iwzu0QvQkiQ+ZXEvLPH+DmP+h9
	YlD4/IF0GNn9dEaEknCFZCGCiSNkkq47RAPrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hvhsH/Xzhaj90mmHqbFHuhgQgz1ypefy
	yNMlGhDklBelSpHLKM2wE/DAFSBm9wVF5r7m/earcA9jINjJOFf7jBsWBZNCDoFP
	g3vowxr3DLNsHiKTriDIJuALOttQOIQdroW4eQT0/eculgHFraeEPDZHB3kXu9ky
	KxUomlercg4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B93D43D99;
	Wed, 17 Feb 2016 15:44:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF07A43D97;
	Wed, 17 Feb 2016 15:44:29 -0500 (EST)
In-Reply-To: <77c2b6f72b55943a0097d81196f520a7fe890310.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DD85A20-D5B7-11E5-A16B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286546>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of coding the retry loop inline, use raceproof_create_file() to
> make lock acquisition safe against directory creation/deletion races.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Makes sense.
