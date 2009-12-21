From: Frank Li <lznuaa@gmail.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 15:29:34 +0800
Message-ID: <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
	 <4B2F214D.2020905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMciB-0008PY-Rp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 08:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZLUH3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 02:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbZLUH3h
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 02:29:37 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:34933 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZLUH3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 02:29:35 -0500
Received: by ywh12 with SMTP id 12so5377502ywh.21
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rhgH2D0SSGy72yBwWg4xVOlozIciM5WroKUbWKa5lWc=;
        b=jOOQDWrHm1z4kz36eT3oWhJyTvpg3QD/GvyKxvZz4ithTrUQtDiqhPjhrz3JYzl2Ao
         ulF2wbJxMmfr52/uABoSXnvCpgT5JFErLuk88xQQf9rxQlbU9ZkN+0skTv/RjQM0Yq1b
         19sWSKWb3Evaxnqd2IF+FAXx943HMFIBs6Ysw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XgwHMczl95ltCKxWX5+dFJr7GnhgT62LkBXub4WCgoxzyIpZVYllbIooKTtJTvFpqz
         7NNSeLxXkenxtuPWlSg5qmbrM+07UI3lW9PnTEgL8KvFzTOrIzHZctfjYlZo20n40vT0
         uEK0b//wE+j879wmGdKadp6dmRPDy+ymfWsAA=
Received: by 10.150.250.21 with SMTP id x21mr10631564ybh.181.1261380574409; 
	Sun, 20 Dec 2009 23:29:34 -0800 (PST)
In-Reply-To: <4B2F214D.2020905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135544>

> This is a commonly used idiom to avoid an (incorrect) compiler warning
> about an uninitialized variable.
>
> Strictly speaking, I think that you are right by saying "means nothing"
> because the use of the uninitialized variable invokes undefined behavior
> (and for this reason, I dislike this construct), but in practice it will
> not make a difference.
>

This error is captured at MSVC environment by run time varible check.
I prefer change it to
int failed_errno = errno;
