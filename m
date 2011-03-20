From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fails to detect subcommand when hook is symlinked to a
 builtin
Date: Sun, 20 Mar 2011 04:09:37 -0500
Message-ID: <20110320090937.GA13167@elie>
References: <20110318151415.GC26236@inocybe.localdomain>
 <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
 <20110319011445.GL26236@inocybe.localdomain>
 <7voc56rj9f.fsf@alter.siamese.dyndns.org>
 <20110320082020.GA12663@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:09:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Ee0-0005em-IU
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 10:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab1CTJJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 05:09:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43524 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1CTJJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 05:09:47 -0400
Received: by iwn34 with SMTP id 34so5464820iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KY4SiSXwT2IJTClI9YB2UKAQawA6Sk4AthdtFXOkoVE=;
        b=V8826Bp9hE85uQdtBOrIrHK+3OhSFCiqWdPkj+kqFHbrDc9n9ye1QDQxnX/hkeyaam
         E+2karaoXJxCFkUxTs2/C+CvI4Hvk35/ZZHfTyxkMj5xNq/+BaHLj2toBWeN4cDUGt67
         ZkLV3sfjWD6FeASOPcHYrBhUThCG9Y1UMZlt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HtKcxSQo9KExdvos+2u/ACURLW/Gzm97vPh/Y2ogrTduON0qyAI//hWoH6sV4p3YA2
         vjfgDUUJzhWwqBKVv3yvtzE2miD5zRL37LisxoGJaFn+EEnvBh4wiknj+IX58KV+3/M9
         K/i2tnXEn7Qg5XT7IjtUqG0HuD4KkwHIdvK58=
Received: by 10.231.33.8 with SMTP id f8mr2940001ibd.22.1300612185312;
        Sun, 20 Mar 2011 02:09:45 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id c1sm2853295ibe.49.2011.03.20.02.09.43
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 02:09:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110320082020.GA12663@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169495>

Jonathan Nieder wrote:

> Instead, the rule is:

Sorry, that came out a muddle.  Teemu Likonen explains the rule[1]
better.  And Linus explains the rationale[2].  The main reason I found
this interesting enough to chime in is that I was considering
proposing changing the beginning of git scripts to

 . "$(git --exec-path)/git-sh-setup"

to set a good example, which would be a regression in git's ability
to complain when used in a fragile way.

So, Todd: thanks for a very useful reminder.

[1] http://thread.gmane.org/gmane.comp.version-control.git/94378
[2] http://thread.gmane.org/gmane.comp.version-control.git/93825
