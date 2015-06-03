From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 03 Jun 2015 11:11:25 -0700
Message-ID: <xmqq4mmoy84y.fsf@gitster.dls.corp.google.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
	<xmqqh9qoy9sx.fsf@gitster.dls.corp.google.com>
	<004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'Ed Avis'" <eda@waniasset.com>, <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:13:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0D9p-0002AG-3H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbbFCSMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:12:48 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:32858 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbFCSL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:11:28 -0400
Received: by iebgx4 with SMTP id gx4so19393786ieb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=10v4QDMSkiTgE0Fqmao0G+RYX7mhdz6NqzNAbIWqdfU=;
        b=PkLJd9XQQJcLU4A7lfJGYFW4Gqu1ABDYnVoGTLPY4u6UsciLRJ+hsxTGXC/ltwkgpZ
         fi8NJIaZo1WCPW/moL9BqHPtTKKUxEiCgq3wW8fUoO/K1dcrMGNjjOqpe5XqWQTIBqOr
         KMhyJytNWEkShR/RN/b8w8BfQMBWuSdo7kP5rFt4uCXm67y6gmifPqqeAk+FD/fLO8iP
         fVxFKo3oxmG9+1o9pm3GgsQOSBq+M55P9jKIVemxcjuemDZV9Mmw+DE4VdCF/TOxUTIQ
         sSlk/CNh505n4e6xqpNaVLWNH2j3T8NakJRDkpcn1yJrMNpRuvLInep212mssNdX6LNC
         6sdA==
X-Received: by 10.42.205.132 with SMTP id fq4mr41815276icb.33.1433355087128;
        Wed, 03 Jun 2015 11:11:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id vk8sm12691922igb.4.2015.06.03.11.11.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 11:11:26 -0700 (PDT)
In-Reply-To: <004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com> (Randall
	S. Becker's message of "Wed, 3 Jun 2015 13:49:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270716>

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On June 3, 2015 1:35 PM Junio C Hamano wrote:
>> Is that really true?  It all depends on why you came to a
>> situation to have "missing files" in the first place, I would
>> think, but "git checkout $path" is "I messed up the version in
>> the working tree at $path, and want to restore them".  One
>> particular kind of "I messed up" may be "I deleted by mistake"
>> (hence making them "missing"), but is it so common to delete
>> things by mistake, as opposed to editing, making a mess and
>> realizing that the work so far was not improving things and
>> wanting to restart from scratch?
>
> When working in an IDE like ECLIPSE or MonoDevelop, accidentally
> hitting the DEL button or a drag-drop move is a fairly common
> trigger for the "Wait-No-Stop-Oh-Drats" process which includes
> running git checkout to recover.

That is an interesting tangent.  If you are lucky then the deleted
file may be unedited one, but I presume that you are not always
lucky.  So perhaps "git checkout" is not a solution to that
particular IDE issue in the first place?
