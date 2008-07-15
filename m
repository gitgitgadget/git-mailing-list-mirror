From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 14 Jul 2008 17:03:14 -0700
Message-ID: <7vhcasdnel.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.o rg>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <487BDD56.7010505@gmail.com>
 <487BDF57.4090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIY1m-0007cW-RH
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbYGOADW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbYGOADV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:03:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760066AbYGOADU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:03:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1201227D00;
	Mon, 14 Jul 2008 20:03:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3B90327CFF; Mon, 14 Jul 2008 20:03:16 -0400 (EDT)
In-Reply-To: <487BDF57.4090900@gmail.com> (Lea Wiemann's message of "Tue, 15
 Jul 2008 01:20:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E5693F2-5201-11DD-A702-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88485>

Lea Wiemann <lewiemann@gmail.com> writes:

> Lea Wiemann wrote:
>> It'll be fixed in the next version I post
>
> By the way Junio, how do you prefer to get reposts of patch sequences?
> Should I repost the whole sequence under a new common parent message, or
> can I simply post v2 of each patch in the sequence as a followup to its
> respective v1?

I do not have major preference either way, but for a long series, I'd
prefer a resend to be independent from the previous series, i.e.

        [PATCH 0/3]
        .[PATCH 1/3]
        ..[PATCH 2/3]
        ...[PATCH 3/3]

        [PATCH 0/4 v2]
        .[PATCH 1/4 v2]
        ..[PATCH 2/4 v2]
        ...[PATCH 3/4 v2]
        ....[PATCH 4/4 v2]
        
I can live with the first one from the new series being a follow-up to the
first one from the old series, i.e.:

        [PATCH 0/3]
        .[PATCH 1/3]
        ..[PATCH 2/3]
        ...[PATCH 3/3]
        .[PATCH 0/4 v2]
        ..[PATCH 1/4 v2]
        ...[PATCH 2/4 v2]
        ....[PATCH 3/4 v2]
        .....[PATCH 4/4 v2]

but _not_ with this, i.e. N/M being followup to old N/M:

        [PATCH 0/3]
        .[PATCH 0/4 v2]
        .[PATCH 1/3]
        ..[PATCH 1/4 v2]
        ..[PATCH 2/3]
        ...[PATCH 2/4 v2]
        ...[PATCH 3/3]
        ....[PATCH 3/4 v2]
        .....[PATCH 4/4 v2]
