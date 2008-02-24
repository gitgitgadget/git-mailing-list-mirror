From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sun, 24 Feb 2008 10:44:35 -0500
Message-ID: <47C190E3.6000407@gmail.com>
References: <47AAA254.2020008@thorn.ws>	<20080207063020.GP24004@spearce.org>	<200802071056.19370.robin.rosenberg.lists@dewire.com>	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 16:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTJ2T-0003wD-8K
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 16:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYBXPok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 10:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbYBXPok
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 10:44:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:21895 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYBXPoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 10:44:39 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1090013wxd.4
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=n4OHGhUBMDI4IVqh4b0nwm0+XwmD/tjeR063NyWdz7Q=;
        b=oZW+hb1nknpAAyhJ8lCMpuKmCS9g/C7S2KWmv+gnDu+0KqTzESRqzBIAJ9d+cAsmz2sWykI9nX+OPvO2seZImZd1cxark0TZ1exqfGiGG6xvaloTRBLFkePj7n6kpJ3isqBXKAThA8nExjYP9nh66IzJ+F7DY+4HJ7+qlYd6nWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lDlz7W7RLMwOt9DzRtoLcS1lwzEwEd9w0ninSbAB/G35s5XIjKHCsHQ346F3szM/uXTL1qCCkQJX1rxm0FFyTgQQHFG6X6UcauyleZCENF8Zq+Sp20EjaKKxHCOlYgxA8rnkle1P+mp/hBkTDyEkfemrBJL+RxvN5Jck1VSmlnU=
Received: by 10.100.168.18 with SMTP id q18mr4239348ane.65.1203867878722;
        Sun, 24 Feb 2008 07:44:38 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.29.241])
        by mx.google.com with ESMTPS id b18sm6269493ana.14.2008.02.24.07.44.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Feb 2008 07:44:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74940>

Paul Mackerras wrote:
> Gerrit Pape writes:
>
>   
>> Saving the geometry can cause several inconveniences, e.g. when using a
>> temporary dual screen setup, or sharing ~/.gitk between multiple
>> systems.  Additionally it can be argued that window placement and sizing
>> are the tasks of the window manager.  So don't do that anymore.
>>     
>
> I myself find it useful to have gitk remember the size and layout of
> the various panes, so I won't be applying this patch.
>
> The saving/restoring of the window position was done by Mark Levedahl
> to make gitk work properly on Cygwin.  I agree it can be annoying on X
> and I would take a patch to inhibit the restoring of the window
> position when running under X.  I'd want an ack from Mark before
> making that change more generally.
>
> Paul.
>
>   
I can only offer to test the proposed patch, I am unable to predict what 
will or won't trip up the buggy geometry engine in Cygwin's Tk. I do 
remember I had trouble finding a way to restore the size but not the 
position of the main window on Cygwin: that doesn't mean it can't be 
done (logically, it should be easy), just that I didn't find the right 
spell or incantation that would work. I'll also admit to not having 
tried after I got to a completely working geometry solution, so perhaps 
just restoring the size without position will now work on Cygwin.

Using the saved panel sizes in conjunction with the default window size 
yields an unusable screen: many elements are obscured. The same occurs 
using the defaults altogether: either way the user must resize and 
adjust things to get to a workable layout. So, I am very opposed to 
disabling the memory altogether. Also, I have a number of X apps that 
remember their layout, so gitk's current behavior is not (at least to 
me) an aberration and I would like that behavior to at least remain an 
option.

Mark
