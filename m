From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 19:40:00 +0100
Message-ID: <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:41:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQy9-0007ru-8y
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbZAWSkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZAWSkD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:40:03 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:48375 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbZAWSkC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:40:02 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4825281rvb.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JnR/oLsfGHCuEUwFSqUlmCKNEeEIgHm00SAgO9lI9h0=;
        b=gTZwAJ9tkaP+X98N72TMvd8yCQoESGeyCqiQWJUb2FRe53+y67C6ZPv2ngsxyjNgdH
         y5nxJWr+BHiSp3UGzMoC9RbORRfyuz/GfFkVs2CBlNnNb6xWDtR6luL8VWckW9bWcUar
         4hbSCZra0jWwukmptI/Ooy81xdusgbMstDMB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NVwV4LXkdO6yRKcXvF+NJYAILURRGqnPBm96OPivZ19UxcUu4y2q1gYkOeZll4GPtP
         s/+6YaU9vBKvbEJYiARBkE0PT0zeZ22yfTPJs1QxvfEloCZ5QR6U3TycSeip6Dimc+f0
         hA45Ok7VsNLjv4arQiiwsUOex/Vz2mdsxMcMs=
Received: by 10.115.18.1 with SMTP id v1mr3124784wai.175.1232736000679; Fri, 
	23 Jan 2009 10:40:00 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106900>

On Fri, Jan 23, 2009 at 00:44, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 22 Jan 2009, Lars Hjemli wrote:
>
>> The new --submodules option is used to trigger inclusion of checked out
>> submodules in the archive.
>>
>> The implementation currently does not verify that the submodule has been
>> registered as 'interesting' in .git/config, neither does it resolve the
>> currently checked out submodule HEAD but instead uses the commit SHA1
>> recorded in the gitlink entry to identify the submodule root tree.
>
> Please understand that I skipped the rest of the patch.

That's too bad, I hoped on some feedback from you on the part of the
commit message which you didn't quote:

>> The plan is to fix these limitations by extending --submodules to allow
>> certain flags/options:
>> a|c|r     include any|checked out|registered submodules
>> H         resolve submodule HEAD to decide which tree to include
>> g:<name>  only include submodules in group <name>
>>
>> The syntax would then become '--submodules[=[a|c|r][H][g:<name>]]' and
>> group membership could be specified in .git/config and/or .gitmodules.
>> The current behavior would then match '--submodules=c' (which might be a
>> sensible default when only --submodules is specified).

Wouldn't such an option address your concern about the
consistency/semantics of the --submodules operation?

--
larsh
