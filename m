From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH]: tree-walk.h: Warning fix
Date: Sat, 23 Jun 2007 23:10:21 -0300
Organization: Mandriva
Message-ID: <20070623231021.40a6f3be@gnut>
References: <20070619231127.7ffe273b@gnut>
	<7v1wg39oqc.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 04:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2HYq-0001cA-HQ
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 04:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXFXCKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 22:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXFXCKj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 22:10:39 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:58717 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXFXCKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 22:10:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 05582178D6;
	Sat, 23 Jun 2007 23:10:37 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ez70s0K0HDWd; Sat, 23 Jun 2007 23:10:32 -0300 (BRT)
Received: from gnut (unknown [189.4.10.162])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 34C92178BA;
	Sat, 23 Jun 2007 23:10:30 -0300 (BRT)
In-Reply-To: <7v1wg39oqc.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50766>

Em Fri, 22 Jun 2007 23:19:55 -0700
Junio C Hamano <gitster@pobox.com> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| > diff --git a/tree-walk.h b/tree-walk.h
| > index ee747ab..625198f 100644
| > --- a/tree-walk.h
| > +++ b/tree-walk.h
| > @@ -22,7 +22,7 @@ static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, co
| >  
| >  static inline int tree_entry_len(const char *name, const unsigned char *sha1)
| >  {
| > -	return (char *)sha1 - (char *)name - 1;
| > +	return (const char *)sha1 - (const char *)name - 1;
| >  }
| >  
| >  void update_tree_entry(struct tree_desc *);
| 
| Grumble.  Incoming "name" is already (const char*), isn't it?
| I'd cast only the sha1 side and apply.

 Yes, you're right. I'll fix it and apply again.

 Thanks a lot for the feedback.
