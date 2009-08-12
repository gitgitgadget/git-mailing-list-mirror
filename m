From: Shaun Cutts <shaun@cuttshome.net>
Subject: Re: git index: how does it work?
Date: Wed, 12 Aug 2009 20:45:48 +0200
Message-ID: <410DBF0B-80A2-4235-B566-B622CA976DA0@cuttshome.net>
References: <loom.20090805T160528-69@post.gmane.org> <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>  <436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net> <fabb9a1e0908121047jf7e6cf1n757cde626c79830c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbIpu-0008MU-Id
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 20:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbZHLSp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZHLSp7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 14:45:59 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:51084 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZHLSp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 14:45:58 -0400
Received: (qmail 3709 invoked from network); 12 Aug 2009 18:45:59 -0000
Received: from apn-95-40-196-84.dynamic.gprs.plus.pl (shaunc@[95.40.196.84])
          (envelope-sender <shaun@cuttshome.net>)
          by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 12 Aug 2009 18:45:57 -0000
In-Reply-To: <fabb9a1e0908121047jf7e6cf1n757cde626c79830c@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125725>

Aha ---

that explains it, then.

Is there a lower-level interface to rename detection than via  
"status"? And... um... hmmm.... how does it work? The hash codes don't  
help for "almost" the same. Is there an approximate string matching  
algorithm built in somewhere?

Thanks,

-- Shaun

On Aug 12, 2009, at 7:47 PM, Sverre Rabbelier wrote:

> Heya,
>
> On Wed, Aug 12, 2009 at 04:52, Shaun Cutts<shaun@cuttshome.net> wrote:
>> Are renames being tracked by the index, and is there a more basic  
>> interface
>> than "status" to query about them?
>
> Nope, git never explicitly tracks renames. Try this:
> $ mv foo bar
> $ git rm --cached foo
> $ git add bar
> $ git status
>
> It'll tell you that you renamed foo to bar, even if you never  
> executed 'git mv'.
>
> This is because git does rename _detection_, that is, it'll notice
> that you have another file with (almost) the same contents, so it
> assumes you did a rename.
>
> -- 
> Cheers,
>
> Sverre Rabbelier
>
