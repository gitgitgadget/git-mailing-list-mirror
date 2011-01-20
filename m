From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Wed, 19 Jan 2011 23:48:13 -0600
Message-ID: <20110120054813.GB4770@burratino>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
 <20110119214827.GA31733@burratino>
 <20110120045046.GB9493@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 06:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfnNr-0002xh-9t
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 06:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab1ATFsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 00:48:30 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35940 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab1ATFs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 00:48:29 -0500
Received: by gwj20 with SMTP id 20so54885gwj.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 21:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3kOsniZuG4By7QHQxXLa6071sfSHYz7ACUXVnQISHj4=;
        b=OvFLFOndWZHFaHANn3fQA551BBvADXrn8soFJKawDEJXiUj7JQpGsGiMEdAh6Ckuq3
         jIRodapGt5Ti13y1Qm+KnD+UcCZ1bpstM2OrQQmcV6cp2lGrGUopSDqN8f45lp36iBGo
         hXRAXcynKocoUzuxzsuGg6pjPxVgJf/ddHOqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lYlipODzGwPrx4iUMNI6h3fzfYK4UtH2pW78LCvgvQm134+8jwWIJGI4VIE9swTLBq
         4mekjRMRVudpsK6wCZYJ10PuDn3guFMjAzXfQdH74OYHPy+grdCNAbJ1ABRRdTHMQBml
         DeA5Lw2I6+viVA+FM4GvV2IEsSr9u/76aWP7o=
Received: by 10.147.35.9 with SMTP id n9mr2202240yaj.24.1295502508619;
        Wed, 19 Jan 2011 21:48:28 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id i10sm9472301anh.32.2011.01.19.21.48.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 21:48:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110120045046.GB9493@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165305>

Ramkumar Ramachandra wrote:

> The functionality to persist blobs that are refenced by
> marks probably shouldn't be in svn-fe at all.

Do you mean svn-fi?

> This filter will need to persist every blob for the entire lifetime of
> the program.

Depending on the interface, couldn't it be possible to rely on svn for
the content of blobs that have already been exported?  If so, one
would only need a place to stash (1) a mapping from mark numbers to
(svn rev, path) pairs and (2) the full text of blobs that have not
been exported as part of a rev yet.

Cheers,
Jonathan
