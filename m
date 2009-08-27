From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: finding unmerged branches
Date: Thu, 27 Aug 2009 22:22:55 +0000
Message-ID: <32541b130908271522u1048dcb1h67b79049e46df1ac@mail.gmail.com>
References: <20090827220241.GA1413@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnOg-0007lH-A0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZH0WXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 18:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZH0WXQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:23:16 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:55327 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZH0WXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 18:23:13 -0400
Received: by mail-yw0-f184.google.com with SMTP id 14so2041281ywh.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ZbKYPajNPsLMjJa26wOjaFwnNwssjohA+iCo4n6tA3o=;
        b=rmkWLpRKt6W7l967FNyeTeKy9EHFmUUQZ2Rqf2YyWMw9ZQfVtDsXyvheZGXIr5ydhK
         LeFzl0lvHpUfMuVjaqhsJSgRET0F1mM+5Rn6251OkB4YzRaPhwiEwhoQtXtyqrdOBWih
         guFLfuGUUK9SwtUfdVTHcpnz0Ssmm777Bbkqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bXlM9tdFjlgRmxyuG4HYCczOHFabLTAW3XCGrzS/nVh4cBwyf9Y2+eC97CBLpmE9vO
         48TxQ70DHTIxtX54XiMRYLFVFsNdw88Tix7wj2qjdODFn/geXpZ11BRgVqKERIX5qsZb
         Mz6xABwr7wtSb6tEG6+VG7BfKmUZXuWAy1zBE=
Received: by 10.151.93.17 with SMTP id v17mr760607ybl.106.1251411795194; Thu, 
	27 Aug 2009 15:23:15 -0700 (PDT)
In-Reply-To: <20090827220241.GA1413@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127227>

On Thu, Aug 27, 2009 at 10:02 PM, Joey Hess<joey@kitenet.net> wrote:
> What I really want is a way to find remote branches that
> are not merged with any of my local branches (or any origin
> branches). A slow and stupid implementation of that is in the
> attached git-unmerged script, and it weeds the branch list
> down to 68 branches, which are mostly really ones I might
> want to look at.

How about:

gitk $(git for-each-ref --format='%(refname)' 'refs/remotes/'; git
for-each-ref --format='^%(refname)' 'refs/heads/')

You could also replace 'gitk' with 'git log', and mess with the
--pretty=format:whatever parameter.

Have fun,

Avery
