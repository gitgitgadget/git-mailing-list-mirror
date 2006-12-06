X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Wed, 6 Dec 2006 20:32:58 +0100
Message-ID: <200612062032.58706.jnareb@gmail.com>
References: <200612040001.13640.jnareb@gmail.com> <200612061351.02712.jnareb@gmail.com> <7vveko3km4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 19:31:24 +0000 (UTC)
Cc: git@vger.kernel.org, Pasky Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=grcheQ+UBMv6CaZNVFrNH/pHOH7jhmk4hV0WZ39fDz4HSfKt0ROi4NkgJUE8zJVhRiz8cuEfHST1QjSC4wI8Wd0VBn2RYCGbd+D/6iTEQIEZnRwzzUbGjdAjsuvA81iOe6rO9xgUaKLWYYXEcsZ/4g0iDO5QztB/vSBP30L/x4M=
User-Agent: KMail/1.9.3
In-Reply-To: <7vveko3km4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33510>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2U8-0001lT-K8 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937456AbWLFTay (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937517AbWLFTay
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:30:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:57695 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937456AbWLFTax (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 14:30:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so242270uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:30:51 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr1393748ugl.1165433451251; Wed, 06
 Dec 2006 11:30:51 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id l40sm30574100ugc.2006.12.06.11.30.50; Wed, 06 Dec
 2006 11:30:50 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> 2. Put the configuration in config file, using/like %features support.
>>    For example gitweb.committags.<committag name> would hold parameters
>>    for <committag>. Committags sequence would be given by sequence of
>>    entries in config file. Comittags without options would have sole
>>    variable entry (which I think is equivalent to being bool variable
>>    and having 1 or 'yes' as value).
> 
> I think gitweb.* in $GIT_DIR/config and a config reader in Perl
> are very sensible things to do, and you would need the config
> reader eventually anyway.  The longer we postpone it, the more
> we risk the temptation to pollute $GIT_DIR/ with the likes of
> "description", "owner", and "homepage", and I do not think we
> want to make this worse.

By the way, what is the formal structure of the config file? Perhaps
something like the notation used in RFC?

Is it possible (and doesn't crash current git config parser) having

  [gitweb]
  	blame = yes
  	pickaxe = no
  	snapshot = bzip2

  [gitweb "committags"]
  	message-id = "http://news.gmane.org/find-root.php?message_id="
  	mantis = "http://bugs.or.cz/view.php?id="
  	url
  	sha1

in the config file?
-- 
Jakub Narebski
