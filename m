From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Sat, 6 Jul 2013 17:55:58 -0700
Message-ID: <20130707005558.GI30132@google.com>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvdGq-0005q5-Je
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab3GGA4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:56:05 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37665 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3GGA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:56:03 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2989956pdj.17
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NNxe5zvtUGYFozFeBTDb+u9uJqlDS7l2b3V6jTMyEK0=;
        b=ROQIjSIrEVB8ViOuSNAKvHJNVDE17iNu9UNTgo9UwZXJCNNpgt1KRUw0GmlluRVU9o
         W+h36hRp9Nv352O0LU+C5P8177CrfQH2EF9ic680sKr3Ma7+1T9e9IBmoGTxO3PylI7T
         WummEfI9R0Hz0Rk4pxzvgMJaJA2y4SeYLlBtK8z+REMzooHneMYC80s6Hd78adiVns6s
         YA75wXgZiKbTIBFba8OGprutyrRNNbqGSVY3dZ0C+GMYoT+tkzOGv2bzYp9KPhBYuG9i
         UyNpsKVYQNC8sOj5vYwWptt6mbDxBEFFUf6Sin8eUpBhtJwTy86UQlrmpAEtRwY+9EXq
         Bi2A==
X-Received: by 10.68.252.233 with SMTP id zv9mr15358402pbc.69.1373158561847;
        Sat, 06 Jul 2013 17:56:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z14sm1366224pbt.0.2013.07.06.17.56.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:56:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229711>

Mark Levedahl wrote:

> Do not use FIFOs on cygwin, they do not work. Cygwin includes
> coreutils, so has mkfifo, and that command does something. However,
> the resultant named pipe is known (on the Cygwin mailing list at
> least) to not work correctly.

Hm.  How would you recommend going about writing a script that takes
output from a command, transforms it, and then feeds it back into
that command's input?  Are sockets a more reliable way to do this kind
of IPC on Cygwin?

See reinit_git and try_dump from t9010-svn-fe.sh for context.

Thanks,
Jonathan
