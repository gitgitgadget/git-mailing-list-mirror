From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Tue, 09 Nov 2010 08:48:16 +0100
Message-ID: <4CD8FCC0.2030500@viscovery.net>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org> <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org> <7v8w13r756.fsf@alter.siamese.dyndns.org> <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 09 08:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFiwL-0000EZ-7R
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 08:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab0KIHsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 02:48:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53073 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752518Ab0KIHsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 02:48:19 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFiwD-0007oN-ES; Tue, 09 Nov 2010 08:48:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 305AC1660F;
	Tue,  9 Nov 2010 08:48:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161020>

Am 11/8/2010 22:56, schrieb Kevin Ballard:
> Basically what I'm trying to say is, we already break one particular
> "rather rare" setup. I would love to come up with a solution that supports
> both setups, but I don't know if one exists outside of using a config
> variable to control whether git attribute patterns support quoting (a solution
> I am not particularly fond of for this case).

Can we perhaps have a pseudo-attribute 'quoted-names' that is to be used
like this:

* quoted-names
"file 1" binary
file.1 -diff

Its meaning would be that the remainder of the current .gitattributes file
is to be parsed with C style path quoting enabled. The glob given with
this attribute is irrelevant and ignored.

I didn't check whether old gits would ignore this unknown attribute.

-- Hannes
