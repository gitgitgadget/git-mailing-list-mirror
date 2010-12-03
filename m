From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to
 be more useful
Date: Fri, 03 Dec 2010 10:55:26 +0100
Message-ID: <4CF8BE8E.4090100@viscovery.net>
References: <20101110015327.GB1503@burratino> <1290629960-60917-1-git-send-email-kevin@sb.org> <20101203080603.GC18202@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:55:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POSMc-0007R4-Iw
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286Ab0LCJzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 04:55:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27158 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab0LCJzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 04:55:32 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1POSMQ-000629-Sv; Fri, 03 Dec 2010 10:55:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 95B3B1660F;
	Fri,  3 Dec 2010 10:55:26 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101203080603.GC18202@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162783>

Am 12/3/2010 9:06, schrieb Jonathan Nieder:
> Kevin Ballard wrote:
>> +			sha1="${line%% *}"
>> +			rest="${line#* }"
>> +			echo "$sha1" > "$DOTEST"/stopped-sha
> 
> Maybe this can be done without relying on details of --pretty=oneline
> format?

No. This is a matter of the syntax of the recipe file. If the details of
--pretty=oneline ever changed, then the way how the boilerplate recipe
file is generated would have to be changed accordingly.

> 
> 			sha1=$(git rev-parse --short HEAD)
> 			rest=$(git show -s --format=%s HEAD)

Shouldn't $sha1 be the one given in the recipe rather than current HEAD?

But most importantly, since $rest is echoed on the terminal, it MUST be
derived from the recipe ($line). Rationale: I replace the commit subject
in the recipe by a reminder what I intend to do when the "edit" command
stops---I don't care so much what the commit subject is.

-- Hannes
