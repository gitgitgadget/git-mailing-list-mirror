From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Mon, 2 Mar 2015 16:32:59 +0700
Message-ID: <20150302093259.GA30459@lanh>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
 <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
 <9EB6341F415E41F3A07F9046056ACE13@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:32:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMiK-00086Q-6x
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbbCBJcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:32:32 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:43301 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbbCBJcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 04:32:31 -0500
Received: by pdjp10 with SMTP id p10so1074648pdj.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VCeS3MpKRnUwHiLKZI+sshoxXXv52BrjEX1pXOKgJJ0=;
        b=QdwqJIh81MJUb/3gKKDupfzY/Y7A31iuN4xt+G9vX8cPni7ckTiUWdb3RVf79olGYT
         /5IfZtV0sj1SAet6oQnBa0PxyNISh+JGfl4Da6ixqeoSc0pB7M8I9CZ5tan/5x1NtuId
         s6/pNS+xpIj4vB/x+76nOihtwNwu7koRGyBqOY1pjWHuZkYJN8T7U6bNR0+5fDfqQeQS
         y/M2vXDhatSxhhuUA9FodBY0J0Lg8oiqbyn8hSpLwFE4Odknv72/n/SIdtWZ/bbnUuJf
         AHp94RAg0FDhfhgrH2DOYyBV4TSK8o/DXGGhvCSKrQ2eH3cRLPaVFpwgjEq0D1IT3Ax2
         8Z4g==
X-Received: by 10.70.134.236 with SMTP id pn12mr27903937pdb.116.1425288750534;
        Mon, 02 Mar 2015 01:32:30 -0800 (PST)
Received: from lanh ([115.73.224.188])
        by mx.google.com with ESMTPSA id cb9sm11415273pad.46.2015.03.02.01.32.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 01:32:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Mar 2015 16:32:59 +0700
Content-Disposition: inline
In-Reply-To: <9EB6341F415E41F3A07F9046056ACE13@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264587>

On Sun, Mar 01, 2015 at 11:06:21PM -0000, Philip Oakley wrote:
> OK, maybe not exactly about protocol, but a possible option would be the 
> ability to send the data as a bundle or multi-bundles; Or perhasps as an 
> archive, zip, or tar.
> 
> Data can then be exchanged across an airgap or pigeon mail. The airgap 
> scenario is likely a real case that's not directly prominent at the 
> moment, just because it's not tha direct.
> 
> There has been discussion about servers having bundles available for 
> clones, but with a multi-bundle, one could package up a large bundle 
> (months) and an increment (weeks, and then days), before an final easy 
> to pack last few hours. That would be a server work trade-off, and 
> support a CDN view if needed.
> 
> If such an approach was reasonable would the protocol support it? etc.

It came up several times. Many people are in favor of it. Some
references..

    http://thread.gmane.org/gmane.comp.version-control.git/264305/focus=264565
    http://thread.gmane.org/gmane.comp.version-control.git/263898/focus=263928
    http://thread.gmane.org/gmane.comp.version-control.git/263898/focus=264000
    http://thread.gmane.org/gmane.comp.version-control.git/238472/focus=238844

This is what I got so far. I think the hard part is how to let
projects control this in a clean and flexible way. Not written in the
patch, but I'm thinking maybe we can allow hooking a remote helper in
standard git://, ssh://, http://... That would give total control to
projects.

-- 8< --
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index ecb0efd..2b99464 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -260,3 +260,34 @@ v2
 'git-upload-pack' and 'git-receive-pack' may advertise this capability
 if the server supports 'git-upload-pack-2' and 'git-receive-pack-2'
 respectively.
+
+redirect
+--------
+
+This capability is applicable for upload-pack and upload-pack-v2
+only. When the client requests this capability it must specify
+supported transport protocol separated by colon,
+e.g. "redirect=http:ftp:ssh:torrent".
+
+Instead of sending a packfile data to the client, the server may send
+4-byte signature { 'L', 'I', 'N', 'K' } followed by a NUL-terminated
+URLs, each one pointing to a bundle. This fake pack ends with an empty
+string.
+
+The bundle does not have to contain all refs requested by the
+client. Different bundles from different URLs could have different
+content. The client must follow one of the links to get a bundle.
+The server must not send URL in a protocol that the client does not
+support.
+
+FIXME: do we keep current connection alive until the bundle is
+downloaded and get a normal pack, or let the client initiate a new
+connection? Or perhaps if the client fails to get the bundle for
+whatever reason, it could send "NAK" to the server and the server
+sends normal packfile data.
+
+FIXME: how do we implement this exactly? The decision to redirect
+should probably be delegated to some hook. Maybe sending all "want"
+lines to the script is enough.. Sending "have" lines is more difficult
+because the server decides when to stop receiving them. That decision
+must be moved to the hook...
-- 8< --
