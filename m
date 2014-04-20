From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: the ".git" folder
Date: Sun, 20 Apr 2014 16:49:44 +0700
Message-ID: <CACsJy8CXADh_wrHeqf47FuBUiF8pq_xboUPnts6mP8iVj0F-Pg@mail.gmail.com>
References: <7F780F951A13B047BB0CE5F6EA9069C121871366@hou150w8xmbx06.hou150.chevrontexaco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Miller, Hugh" <HughMiller@chevron.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 11:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WboOE-00073E-As
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 11:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbaDTJuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 05:50:17 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:56540 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbaDTJuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2014 05:50:15 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so2960296qaq.15
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4EqCte5Fuemxf+Ep4cNaZA2RuAFvieLjBbulJuqhkCY=;
        b=IvrpKm9LFw+e6uGl2yF2UhP88DwiiUyxqiyqHyPcMEEke5Y8DMTxZetfSdLHm2BDT3
         oLU4u96cpoXbmQV0BydpSut7aa2e7pN4J+80Z7QcxiD6ko4JX7FcuYjR6XGaCndr0e+M
         cHCJzroB7hizsgc9AuEJJdPvoEutUMyJllY9775xZI8YGynoIbrPboaTWvH4AoyUV6ou
         AwQvWg5oKDkvWxlWuSXZLtpoUlsqS6Unr+gMmbMvwIooBenxlQXV4Ofm4fXr9P2l2NzX
         YJ6Oq27PRFaJxoZdi1JQl0EH24oLO3BnVhvb0dPL2ZBdtlQWAPKrKlBWwnnqVblRUPXs
         DbYg==
X-Received: by 10.140.107.229 with SMTP id h92mr35976909qgf.30.1397987414477;
 Sun, 20 Apr 2014 02:50:14 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sun, 20 Apr 2014 02:49:44 -0700 (PDT)
In-Reply-To: <7F780F951A13B047BB0CE5F6EA9069C121871366@hou150w8xmbx06.hou150.chevrontexaco.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246547>

On Sun, Apr 20, 2014 at 4:13 PM, Miller, Hugh <HughMiller@chevron.com> wrote:
> Dear Community,
>
> Is there any way to use .git (e.g., a different set of "client" commands) that allows the .git folder to be placed in a location away from the actual files being versioned ? For example, can one set environment variables that let the software know where the .git folder is ?

Try

git --git-dir=<new .git location> --work-tree=<top work tree location>
<some command>

The reason of two arguments instead of one is because .git is also
used to mark top work tree location, which is now lost after you move
.git elsewhere. You could also set environment variables GIT_DIR and
GIT_WORK_TREE, which have the same effect. "man git" for details.
-- 
Duy
