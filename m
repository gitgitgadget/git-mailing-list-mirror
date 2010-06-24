From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 15:06:41 -0500
Message-ID: <20100624200641.GA2209@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624105339.GC12376@burratino>
 <AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com>
 <20100624185521.GB1848@burratino>
 <AANLkTikNV0m5E7982wY5wdtcMstpfKKMX4MdZvdhqhOb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORshY-0001t1-MH
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab0FXUG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:06:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58818 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0FXUGz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:06:55 -0400
Received: by iwn41 with SMTP id 41so1178215iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vBmgf6hNGvHCVL0MP5QMRo29IK5db8Bhj3uRCmFEdFI=;
        b=AxAARQp1YkmYjb++4EKVHFjyGTJKTx0w1deuO5TyQb+QQOY+Wv3ShPTJ/ikexa4LkO
         fSPhdFcpncYxEpYvw5q137d39F0+EkDyBcOGlaf98/Ih/7w9ui6CzXh8UhWnxL50ied9
         x4s0nZxS8rsyUJARZOLXbnBTuxFe4b8wgWklQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KqYJxF04ETPjD4AW6xckzQ/V9LEta+wkkUFVOmqteKdr8JOyBtl44yNYwGA8alpV+t
         fTOFBUfCqGxELvbzLwQNumteDjOBRuu/KpSuvh/tauIioFY8HpYgTli07KNDJ+q6cYMC
         n+Ei+aGTVeU9qq+L33s0DVhvp1epXWSfzAOHA=
Received: by 10.231.59.80 with SMTP id k16mr11377115ibh.114.1277410014330;
        Thu, 24 Jun 2010 13:06:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm36438005ibi.20.2010.06.24.13.06.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:06:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikNV0m5E7982wY5wdtcMstpfKKMX4MdZvdhqhOb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149630>

Ramkumar Ramachandra wrote:

> The
> following functions are unused: blob_init, blob_offset, blob_commit,
> commit_free, commit_offset, dir_free, node_init, node_commit,
> string_offset, tree_first, tree_next, tree_remove, log_init,
> log_offset, and log_commit.

Thanks for this list.  Do you think it=E2=80=99s worth automating its
production?  i.e., a masochistic person could write a script to
compile with the __attribute__((unused)) suppressed, parse warnings to
find unused functions, and then take an intersection of sets to
confirm that no family of functions is unused.

Jonathan
