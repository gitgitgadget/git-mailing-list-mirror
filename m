From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to
 be more useful
Date: Fri, 3 Dec 2010 04:00:59 -0600
Message-ID: <20101203100059.GA12043@burratino>
References: <20101110015327.GB1503@burratino>
 <1290629960-60917-1-git-send-email-kevin@sb.org>
 <20101203080603.GC18202@burratino>
 <4CF8BE8E.4090100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 11:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POSS8-0001lf-2x
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 11:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab0LCKBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 05:01:15 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab0LCKBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 05:01:14 -0500
Received: by ywl5 with SMTP id 5so4664285ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QnzCKbeCvLMlS8q7IdsHRfYtOSmSbDB0r/eGa2rlyto=;
        b=eNCRnBxU7yZmo9oULM3z/6b2u4p0vA2kR87McfAYibzDergm4XvqXK1ZRnCjLBEfOV
         ibDfRuCBR451/t+SJsc6Co4t/REFuED1WA/M48dSdO/eV7EcWlZ6jiGYp7rueHE5j1/I
         mcgrSWfK6Ptq5rV+uMPdobQrxLFLqX2vw8bLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N5VzC0+riGDUGc/WKbwXE/iW/UQel23ilpmKjizl0BYSjc553fuXqOeZv8Nn+rg2Vn
         NoMbj9ER59Zd9ggn9AzB85PqdG0ku04Svb4PihU7Rk0xTRFLtmJ0r5GElxO8fsTBQNzU
         CVmLPgx+55mZox1HuDA/PpnUWnZElkN7csMZA=
Received: by 10.100.171.10 with SMTP id t10mr1371212ane.26.1291370473772;
        Fri, 03 Dec 2010 02:01:13 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id f10sm1627466anh.25.2010.12.03.02.01.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 02:01:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF8BE8E.4090100@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162784>

Johannes Sixt wrote:
> Am 12/3/2010 9:06, schrieb Jonathan Nieder:

>> Maybe this can be done without relying on details of --pretty=oneline
>> format?
>
> No. This is a matter of the syntax of the recipe file.

My suggestion was nonsense for other reasons, too.

>> 
>> 			sha1=$(git rev-parse --short HEAD)
>> 			rest=$(git show -s --format=%s HEAD)
>
> Shouldn't $sha1 be the one given in the recipe rather than current HEAD?

This code branch is about mentally rewriting

	pick 87a78c
	fixup 987ca
	edit - time to test

to

	pick 87a78c
	fixup 987ca
	edit <whatever is HEAD at that moment>

and printing "time to test" as a reminder to the user.

> But most importantly, since $rest is echoed on the terminal, it MUST be
> derived from the recipe ($line). Rationale: I replace the commit subject
> in the recipe by a reminder what I intend to do when the "edit" command
> stops---I don't care so much what the commit subject is.

Kevin, this sounds like a vote for the "replace commit message" output
format.

Thanks, that was useful.
Jonathan
