From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] setup: suppress implicit "." work-tree for bare repos
Date: Fri, 08 Mar 2013 08:44:20 +0100
Message-ID: <513996D4.6060009@viscovery.net>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com> <20130308054824.GA24429@sigill.intra.peff.net> <20130308071554.GB24429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 08:44:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDrz0-0000m5-Up
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 08:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab3CHHo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 02:44:27 -0500
Received: from so.liwest.at ([212.33.55.24]:52134 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab3CHHo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 02:44:26 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UDryW-0000tf-Fy; Fri, 08 Mar 2013 08:44:20 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 38C6F1660F;
	Fri,  8 Mar 2013 08:44:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130308071554.GB24429@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217644>

Am 3/8/2013 8:15, schrieb Jeff King:
> --- a/cache.h
> +++ b/cache.h
> @@ -344,6 +344,7 @@ static inline enum object_type object_type(unsigned int mode)
>  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
>  #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
>  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
> +#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
>  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
>  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
>  #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"

This new variable needs to be added to environment.c:local_repo_env, right?

-- Hannes
