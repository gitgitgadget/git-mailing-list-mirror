From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 11:54:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810211153130.26244@xanadu.home>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
 <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 18:20:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsJxo-00050e-M5
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 18:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbYJUQSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYJUQSe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 12:18:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15870 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbYJUQSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 12:18:33 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9300ESDIUGJU1Q@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Oct 2008 11:54:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98791>

On Tue, 21 Oct 2008, Nguyen Thai Ngoc Duy wrote:

> On 10/21/08, Nicolas Pitre <nico@cam.org> wrote:
> > Before commit d0b92a3f6e it was possible to run 'git index-pack'
> >  directly in the .git/objects/pack/ directory.  Restore that ability.
> 
> I am sorry I did not catch this in the first place. While the fix
> should be fine for "git index-pack". I wonder what can happen for
> other setup_*_gently()'s consumers. Other commands may be affected too
> (e.g. running "git apply" or "git bundle" from inside .git).

Normally you should not be running such commands inside the .git 
directory.  The index-pack command is a bit special in that regard.


Nicolas
