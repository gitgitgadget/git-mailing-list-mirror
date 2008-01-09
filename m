X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 09 Jan 2008 17:37:07 +0000
Message-ID: <C3AAB6C3.10C6B%jefferis@gmail.com>
References: <20080109150310.GC23659@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 9 Jan 2008 17:37:36 +0000 (UTC)
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Dmitry Potapov <dpotapov@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=IQ/fSCkT7Fuu+CXOT6iI4uNL2Wpbr272ydlvEoLW7lk=;
        b=PBVUKCJrCnx9p4tNn/1X9eW3eLg3DvC1GYwmhB+d3w+hxgfUNNgNPrIX5n0lX1Q0i+rFicyDkBbWj+4fmnUV69jig8q0he9s5Y/NUGH0DYPaisHXWXXTwbuZVJxhfjrMN/d3JhSfM+cyacaG3lk/mKPGkPIa3Xrds70ER2rzhg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=N2lIHxv2vHbj2F/NcdE5G/mq0/6aALXyRGIiPc5wdEmvBsVoRD2kwfoUhtwmXOlFMvZ1F/wmZoLUUPa0D1ZoXTq0jbs9W3rITZi/Q4D1VkSvDmcnFf258wKEYzgvIqxxNSxUkSVPqX8pTYVkD2X6xTggcPKHr6SCu3BAQrokTRE=
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchS5kE0f+ct/b7ZEdyK5wAUURoPUg==
In-Reply-To: <20080109150310.GC23659@dpotapov.dyndns.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1JCes9-000490-Ec for gcvg-git-2@gmane.org; Wed, 09 Jan 2008
 18:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752379AbYAIRhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008
 12:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbYAIRhT
 (ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 12:37:19 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:33973 "EHLO
 fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752379AbYAIRhR (ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Jan
 2008 12:37:17 -0500
Received: by fk-out-0910.google.com with SMTP id z23so205422fkz.5 for
 <git@vger.kernel.org>; Wed, 09 Jan 2008 09:37:15 -0800 (PST)
Received: by 10.78.150.7 with SMTP id x7mr1030241hud.48.1199900235708; Wed,
 09 Jan 2008 09:37:15 -0800 (PST)
Received: from ?10.2.2.59? ( [131.111.85.79]) by mx.google.com with ESMTPS id
 33sm1589845nfu.9.2008.01.09.09.37.12 (version=TLSv1/SSLv3 cipher=OTHER); Wed,
 09 Jan 2008 09:37:14 -0800 (PST)
Sender: git-owner@vger.kernel.org

On 9/1/08 15:03, "Dmitry Potapov" <dpotapov@gmail.com> wrote:

> On Wed, Jan 09, 2008 at 01:52:59PM +0000, Gregory Jefferis wrote:
>> 
>> Re point (1) to be reversible in practice, we need to know who we've munged.
>> Otherwise when gnuming blindly at checkout we might damage some innocent
>> bystander file that only ever had LFs in the first place.
> 
> If you work on Windows and you have clrf=safe, you cannot put a text
> file that has only LFs, because naked LF is not allowed. If you want
> to have naked LF in some file, you have to say that explicitly in
> .gitattributes.
> 
> If you work on cross platform project, and somebody else put a file with
> bare LFs, which is not text though heauristic wrongly detected it as
> text then you can remove this file from your working directory, correct
> .gitattributes and checkout this file again. The idea of crlf=safe is
> that information is never lost. It is always fully reversible, and if
> you put something into the repostory, you always get back exactly the
> same unless you changed your .gitattributes.
> 
>> Re (2) well if we happen to munge a file on checkin that is actually binary,
>> it must be gnumed on the way out otherwise it will be broken for the user.
> 
> Of course, it will, because the same heuristic will detect it as text,
> and convert it back. So as long as you stay on the same platform and
> with the same .gitattributes, you always get back exactly what you
> put.

Dmitry, I think all of your comments are correct, BUT, this behaviour as
currently proposed still does not seem to me safe (or perhaps transparent)
enough to be enabled by default on a Windows platform (or for that matter a
Unix one).

If LF text files checked in on Windows get turned into CRLF files on
checkout by default then I think plenty of people would be surprised and
probably unhappy.  Similarly I think it would be a bad thing if a binary
file that looked like LF only text got mangled on checkout by LF->CRLF
conversion - although I agree that it would be possible to recover from this
situation with a bit of juggling.

So my view is still that this behaviour would be a useful option when
explicitly enabled by .gitattributes (as opposed to the current auto CRLF
implementation, which could lead to irreversible munging) but that it is not
an appropriate system-wide default.  I could however see that sane people
might disagree! 

For that matter autocrlf=true,input,safe are all slightly dubious when used
as config vars rather than as attributes for the same collateral damage
reason discussed above.  The only way to prevent collateral damage is to
consult .gitattributes on checkout (as Dmitry seemed to be assuming above)
rather than gnuming anything in the repository that looked like LF only
text.  Of course even .gitattributes can change over time, so only by
storing a "munged" metadata attribute in the repository could you guarantee
that everything came out as it went in - which I think is a highly desirable
base state.  

Greg.

